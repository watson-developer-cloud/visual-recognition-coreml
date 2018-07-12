//
//  VisualRecognition+Extensions.swift
//  Core ML Vision
//
//  Created by Nicholas Bourdakos on 7/12/18.
//

import VisualRecognitionV3
import CoreML

extension VisualRecognition {
    /// Helper function for choosing the proper initializion (old / IAM) of `VisualRecognition`.
    static func easyInit(apiKey: String, version: String) -> VisualRecognition {
        // API keys from before May 23, 2018 should only contain hex values.
        let allowedChars = CharacterSet(charactersIn: "abcdef0123456789")
        
        // Check if the provided key contains only hex characters.
        let onlyHex = allowedChars.isSuperset(of: CharacterSet(charactersIn: apiKey))
        
        // Older keys seem to be 40 characters, but I have not confirmed this.
        if apiKey.count <= 40 && onlyHex {
            return VisualRecognition(apiKey: apiKey, version: version)
        }
        
        /*
         Default to IAM.
         IAM keys appear to have 44 characters (haven't confirmed) and aren't restricted to hex values.
         If I'm wrong about the size of the keys, it's possible that an IAM key could have all hex
         characters and be misclassified as an old api key if it has 40 characters.
         (At 40 chars the chance that an IAM key has all hex values is 0.0000000000000000000000827%)
         */
        return VisualRecognition(version: version, apiKey: apiKey)
    }
    
    /// Helper function for checking if a model needs to be updated.
    func checkLocalModelStatus(classifierID: String, modelUpToDate: @escaping (Bool) -> Void) {
        // setup date formatter '2017-12-04T19:44:27.419Z'
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        // load model from disk
        guard let model = try? getLocalModel(classifierID: classifierID) else {
            // There is no local model so it can't be up to date.
            modelUpToDate(false)
            return
        }
        
        // parse the date on which the local model was last updated
        let description = model.modelDescription
        let metadata = description.metadata[MLModelMetadataKey.creatorDefinedKey] as? [String: String] ?? [:]
        guard let updated = metadata["retrained"] ?? metadata["created"], let modelDate = dateFormatter.date(from: updated) else {
            modelUpToDate(false)
            return
        }
        
        // parse the date on which the classifier was last updated
        getClassifier(classifierID: classifierID, failure: nil) { classifier in
            guard let dateString = classifier.retrained ?? classifier.created, let classifierDate = dateFormatter.date(from: dateString) else {
                DispatchQueue.main.async {
                    modelUpToDate(false)
                }
                return
            }
            
            if classifierDate > modelDate && classifier.status == "ready" {
                DispatchQueue.main.async {
                    modelUpToDate(false)
                }
            } else {
                DispatchQueue.main.async {
                    modelUpToDate(true)
                }
            }
        }
    }
}
