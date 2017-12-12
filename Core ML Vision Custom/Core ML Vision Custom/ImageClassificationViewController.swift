//
//  ViewController.swift
//  Core Ml Vision Simple
//
//  Created by Iain McCown on 11/29/17.
//  Copyright © 2017 Iain McCown. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO
import VisualRecognitionV3

class ImageClassificationViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var currentModelLabel: UILabel!
    @IBOutlet weak var modelUpdateActivityIndicator: UIActivityIndicatorView!
    
    let apiKey = ""
    let classifierId = ""
    let version = "2017-12-07"
    var visualRecognition: VisualRecognition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentModelLabel.text = "Current Model: \(classifierId)"
        self.visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        self.invokeModelUpdate()
        // Check for model updates every 60 seconds
        let _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(ImageClassificationViewController.invokeModelUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func invokeModelUpdate()
    {
        let failure = { (error: Error) in
            print(error)
            DispatchQueue.main.async {
                self.currentModelLabel.text = "Error updating model"
                self.modelUpdateActivityIndicator.stopAnimating()
            }
        }
        
        let success = {
            DispatchQueue.main.async {
                self.currentModelLabel.text = "Current Model: \(self.classifierId)"
                self.modelUpdateActivityIndicator.stopAnimating()
            }
        }
        
        self.currentModelLabel.text = "Updating model..."
        self.modelUpdateActivityIndicator.startAnimating()
        visualRecognition.updateCoreMLModelLocally(classifierID: classifierId, apiKey: apiKey, failure: failure, success: success)
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
            print(error)
        }
        
        visualRecognition.classifyLocally(image: image, classifierIDs: [classifierId], failure: failure) { classifiedImages in
            print(classifiedImages)
            let filtered = classifiedImages.images[0].classifiers[0].classes.prefix(2) //  limit results to 2

            // Update UI on main thread
            DispatchQueue.main.async {
                if filtered.isEmpty {
                    self.classificationLabel.text = "Unrecognized."
                } else {
                    let descriptions = filtered.map { classification in
                        // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".
                        return String(format: "  (%.4f) %@", classification.score, classification.classification)
                    }
                    self.classificationLabel.text = "Classification: \(filtered[0].classification)"
                }
            }
        }
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
        
        classifyImage(for: image, localThreshold: 0.1)
    }
}


