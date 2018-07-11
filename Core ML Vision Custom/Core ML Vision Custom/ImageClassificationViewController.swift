/**
 * Copyright IBM Corporation 2017, 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import CoreML
import Vision
import ImageIO
import VisualRecognitionV3

struct VisualRecognitionConstants {
    // Instantiation with `api_key` works only with Visual Recognition service instances created before May 23, 2018. Visual Recognition instances created after May 22 use the IAM `apikey`.
    static let apikey = ""     // The IAM apikey
    static let api_key = ""    // The apikey
    static let classifierId = ""
    static let version = "2018-03-19"
}

class ImageClassificationViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var currentModelLabel: UILabel!
    @IBOutlet weak var updateModelButton: UIBarButtonItem!
    
    let visualRecognition: VisualRecognition = {
        if !VisualRecognitionConstants.api_key.isEmpty {
            return VisualRecognition(apiKey: VisualRecognitionConstants.api_key, version: VisualRecognitionConstants.version)
        }
        return VisualRecognition(version: VisualRecognitionConstants.version, apiKey: VisualRecognitionConstants.apikey)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Pull down model if none on device
        guard let localModels = try? visualRecognition.listLocalModels() else {
            return
        }
        if localModels.contains(VisualRecognitionConstants.classifierId) {
            currentModelLabel.text = "Current Model: \(VisualRecognitionConstants.classifierId)"
        } else {
            invokeModelUpdate()
        }
    }
    
    //MARK: - Model Methods
    
    func invokeModelUpdate() {
        let failure = { (error: Error) in
            print(error)
            let descriptError = error as NSError
            DispatchQueue.main.async {
                self.currentModelLabel.text = descriptError.code == 401 ? "Error updating model: Invalid Credentials" : "Error updating model"
                SwiftSpinner.hide()
            }
        }
        
        let success = {
            DispatchQueue.main.async {
                self.currentModelLabel.text = "Current Model: \(VisualRecognitionConstants.classifierId)"
                SwiftSpinner.hide()
            }
        }
        
        SwiftSpinner.show("Compiling model...")
        
        visualRecognition.updateLocalModel(classifierID: VisualRecognitionConstants.classifierId, failure: failure, success: success)
    }
    
    
    @IBAction func updateModel(_ sender: Any) {
        invokeModelUpdate()
    }
    
    
    // MARK: - Photo Actions
    
    @IBAction func takePicture() {
        // Show options for the source picker only if the camera is available.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            presentPhotoPicker(sourceType: .photoLibrary)
            return
        }
        
        let photoSourcePicker = UIAlertController()
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .camera)
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { [unowned self] _ in
            self.presentPhotoPicker(sourceType: .photoLibrary)
        }
        
        photoSourcePicker.addAction(takePhoto)
        photoSourcePicker.addAction(choosePhoto)
        photoSourcePicker.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(photoSourcePicker, animated: true)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }
    
    // MARK: - Image Classification
    
    func classifyImage(for image: UIImage, localThreshold: Double = 0.0) {
        
        classificationLabel.text = "Classifying..."
        
        let failure = { (error: Error) in
            self.showAlert("Could not classify image", alertMessage: error.localizedDescription)
        }
        
        visualRecognition.classifyWithLocalModel(image: image, classifierIDs: [VisualRecognitionConstants.classifierId], threshold: localThreshold, failure: failure) { classifiedImages in
            
            var topClassification = ""

            if classifiedImages.images.count > 0 && classifiedImages.images[0].classifiers.count > 0 && classifiedImages.images[0].classifiers[0].classes.count > 0 {
                topClassification = classifiedImages.images[0].classifiers[0].classes[0].className
            } else {
                topClassification = "Unrecognized"
            }

            // Update UI on main thread
            DispatchQueue.main.async {
                // Display top classification ranked by confidence in the UI.
                self.classificationLabel.text = "Classification: \(topClassification)"
            }
        }
    }
    
    //MARK: - Error Handling
    
    // Function to show an alert with an alertTitle String and alertMessage String
    func showAlert(_ alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension ImageClassificationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Handling Image Picker Selection
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: true)
        
        // We always expect `imagePickerController(:didFinishPickingMediaWithInfo:)` to supply the original image.
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.image = image
        
        classifyImage(for: image, localThreshold: 0.2)
    }
}


