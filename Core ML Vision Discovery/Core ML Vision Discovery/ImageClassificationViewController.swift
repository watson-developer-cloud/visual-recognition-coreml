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
import Pulley
import VisualRecognitionV3
import DiscoveryV1

class ImageClassificationViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var displayContainer: UIView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    let visualRecognitionApiKey = ""
    let visualRecognitionClassifierID = ""
    let discoveryUsername = ""
    let discoveryPassword = ""
    let discoveryEnvironmentID = ""
    let discoveryCollectionID = ""
    let version = "2017-11-10"
    var visualRecognition: VisualRecognition!
    var watsonModel: VisualRecognitionCoreMLModel!
    var discovery: Discovery!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.visualRecognition = VisualRecognition(apiKey: visualRecognitionApiKey, version: version)
        self.discovery = Discovery(username: discoveryUsername, password: discoveryPassword, version: version)
        
        if let model = try? VNCoreMLModel( for: MobileNet().model ) {
            watsonModel = VisualRecognitionCoreMLModel( model: model )
        }
    }
    
    //MARK: - Pulley Library methods
    
    private var pulleyViewController: PulleyViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PulleyViewController {
            self.pulleyViewController = controller
        }
    }
    
    // MARK: - Display Methods
    
    func displayImage( image: UIImage ) {
        if let pulley = self.pulleyViewController {
            if let display = pulley.primaryContentViewController as? ImageDisplayViewController {
                display.image.contentMode = UIViewContentMode.scaleAspectFit
                display.image.image = image
            }
        }
    }
    
    // Convenience method for pushing data to the TableView.
    func getTableController(run: (_ tableController: ResultsTableViewController, _ drawer: PulleyViewController) -> Void) {
        if let drawer = self.pulleyViewController {
            if let tableController = drawer.drawerContentViewController as? ResultsTableViewController {
                run(tableController, drawer)
                tableController.tableView.reloadData()
            }
        }
    }
    
    // Parse  cable classification information. Check whether there is any indication of damage
    func sortClassifications(data: [VisualRecognitionV3.Classification]) -> [String: String] {
        var label = ""
        var damage = ""
        label = data[0].classification
        for classification in data {
            let unparsedLabel = classification.classification
            if unparsedLabel.contains("_male") || unparsedLabel.contains("_female") {
                var labelWords = unparsedLabel.components(separatedBy: "_")
                labelWords[0] = labelWords[0].uppercased()
                label = labelWords.joined(separator: " ")
            } else if unparsedLabel.contains("_faulty") {
                let damageDescription = unparsedLabel.replacingOccurrences(of: "_faulty", with: "")
                damage = damageDescription.prefix(1).uppercased() + String(damageDescription.dropFirst())
            }
        }
        label = label.count > 0 ? label : "Unrecognized"
        return ["classification": label, "damage": damage]
    }
    
    // Convenience method for pushing classification data to TableView
    func displayResults(data: [VisualRecognitionV3.Classification]) {
        getTableController { tableController, drawer in
            if drawer.drawerPosition == .open {
                return // assume user is inspecting results
            }
            let parsedData = sortClassifications(data: data)
            let classification = parsedData["classification"]!
            tableController.classificationLabel = classification
            tableController.damage = parsedData["damage"]!
            let damaged = parsedData["damage"]!.count > 0
            if classification != "Unrecognized" {
                print("fetching discovery")
                fetchDiscoveryResults(query: classification, damaged: damaged)
            }
            self.dismiss(animated: false, completion: nil)
            //            drawer.setDrawerPosition(position: .collapsed, animated: true)
        }
    }
    
    // MARK: - Discovery Methods
    
    // Convenience method for pushing discovery data to TableView
    func displayDiscoveryResults(data: String, title: String = "", subTitle: String = "") {
        getTableController { tableController, drawer in
            tableController.discoveryResult = data
            tableController.discoveryResultTitle = title
            tableController.discoveryResultSubtitle = subTitle
            self.dismiss(animated: false, completion: nil)
            //            drawer.setDrawerPosition(position: .collapsed, animated: true)
        }
    }

    
    // Method for querying Discovery
    func fetchDiscoveryResults(query: String, damaged: Bool = false) {
        DispatchQueue.main.async {
            self.displayDiscoveryResults(data: "Retrieving more information on " + query + "...")
        }
        
        let failure = { (error: Error) in
            print(error)
        }
        
        let queryItem = query.components(separatedBy: " ")[0]
        print(queryItem)
        var generalQuery = ""
        var filter = ""
        // search for troubleshooting information if cable is damaged
        if damaged {
            generalQuery = "text%3A%22faulty%20" + queryItem + "%22"
        } else { // search for general information if cable is not damaged
            generalQuery = "extracted_metadata.title%3A%22What%20is%20" + queryItem + "%3F%22"
            filter = "text%3A%21%22faulty%22"
        }
        self.discovery.queryDocumentsInCollection(
            withEnvironmentID: discoveryEnvironmentID,
            withCollectionID: discoveryCollectionID,
            withFilter: filter,
            withQuery: generalQuery,
            failure: failure)
        {
            queryResponse in
            if let results = queryResponse.results {
                DispatchQueue.main.async() {
                    print(queryResponse)
                    var truncatedString = ""
                    var sectionTitle = ""
                    var subTitle = ""
                    if results.count > 0 {
                        let text = results[0].text as! String
                        truncatedString = text.count >= 350 ? text.prefix(350) + "..." : text
                        sectionTitle = damaged ? "Troubleshooting" : "Description"
                        subTitle = query
                    } else {
                        print(results)
                    }
                    self.displayDiscoveryResults(data: truncatedString, title: sectionTitle, subTitle: subTitle)
                }
            }
        }
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
        
        let failure = { (error: Error) in
            print(error)
        }
        // TODO: remove this line once SDK switches to using UIImage
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        self.visualRecognition.classify(image: imageData!, model: watsonModel.model, localThreshold: localThreshold, failure: failure) { classifiedImages in
            let filtered = classifiedImages.images[0].classifiers[0].classes.prefix(2) //  limit results to 2
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.displayResults( data: Array(filtered) )
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
        DispatchQueue.main.async {
            self.displayImage( image: image )
        }
        
        classifyImage(for: image, localThreshold: 0.1)
    }
}


