# Watson Core ML Starter Kit.
A repo containing the basics to get started classifying images using local Watson Visual Recognition models using Core ML. The included Xcode workspace contains two projects: `Core ML Vision Simple` and `Core ML Vision Custom Training`.






## Before you begin
### Getting the project
1. Download the project from GitHub. You can either clone the project or download it as a zip folder.

2. Open the workspace `QuickstartWorkspace.xcworkspace` in Xcode. You will see two projects. The first project ([Core ML Vision Simple](#core-ml-vision-simple)) is already pre-packaged with everything you need. It comes bundled with a base Watson Visual Recognition Model. The second project is set up to incorporate a custom Visual Recognition model. We will walk through the steps of creating your own model in [Core ML Vision Custom Training](#core-ml-vision-custom-training). 

### Provisioning an instance of Visual Recognition
For the [Core ML Vision Custom Training](#core-ml-vision-custom-training) you will need a Bluemix account and an `api_key` for an instance of the Watson Visual Recognition service. An instance of Visual Recognition is not required for [Core ML Vision Simple](#core-ml-vision-simple).
1) Click <a href="https://console.bluemix.net/registration/trial/?target=%2Fdeveloper%2Fwatson%2Fcreate-project%3Fservices%3Dwatson_vision_combined%26action%3Dcreate%26hideTours%3Dtrue" target="blank">this link</a> to create an instance of the Visual Recognition service. You will need to create a bluemix account if you do not already have one.

2) Copy the `api_key` for the service instance for use in the [Core ML Vision Custom Training](#core-ml-vision-custom-training) project.






## Core ML Vision Simple
A basic implemenation of Watson Visual Recognition using Core ML.

1) In Xcode, ensure the active scheme is `Core ML Vision Simple`.

Using the Simulator

2) Select an iPhone simulator target and click the play button to build and run the active scheme.
3) On the simulator, click the `camera` icon and select a photo from your photo library to classify. Note: You can add custom photos to the simulator by dragging them from your Finder to the simulator device.

Using a device

2) Select the device to which you would like to publish the application. 
3) Select the target `Core ML Vision Simple`, under `Identity` select a unique `Bundle Identifier` and under `Signing` select the team you would like use to sign the application.
4) Click the play button to build and run the active scheme on the device.
5) If the device shows an Untrusted Developer error, go to `Settings` > `General` > `Device Managment`. Select the team you used to sign the application and trust the profile.
4) On the device, click the `camera` icon and either take a photo of what you would like to classify (You will need to allow the application permissions to access the device camera) or select an image to be classified from your library. 






## Core ML Vision Custom Training
Watson Visual Recognition using Core ML, with the ability to train the base model and pull down updated versions. This guide will walk you through training a custom model on common cables (HDMI, USBC, etc.) and incorporating the custom model into your visual recognition application using the Watson Swift SDK

### Getting Started
1. You will need Carthage to download the Watson SDK framework, if you do not already have Carthage installed you can follow instructions [here](https://github.com/Carthage/Carthage#installing-carthage)

2. Download the latest SDK by opening your terminal, navigating to the Core ML Vision Custom/ directory and running the following command
```
carthage update
```
**Temporary Note:** Until the updates to the SDK are made public, you will need to download the development version of the SDK [here](https://github.ibm.com/watson-embed-partnerships/pluto-swift-sdk). Make sure that it is at the same level as this project in whatever directory you save this project in. You may need to periodically pull down updates from the SDK github when you pull down updates for this project.

3. After the package is done installing, you will find the Visual Recognition framework in the Carthage/Build/iOS directory. From this folder, drag `VisualRecognitionV3.framework` into your project's workspace, in the Core Ml Vision Custom\ directory. The Watson Swift SDK makes it easy to keep track of your custom Core ML models and pull down new versions of custom classifiers from the IBM Cloud and store them on your device.

4. Once you've dragged the framework into the workspace, go to the Core ML Vision Custom project settings by clicking on the project in the Project navigator. Under 'General,' scroll down to Embedded Binaries and click the '+' sign. Select the VisualRecognitionV3.framework.

5. Paste the `api_key` from obtained from [Provisioning an instance of Visual Recognition](#provisioning-an-instance-of-visual-recognition). Paste it at the top of the `ImageClassificationViewController.swift` file in your project, where it says `apiKey = ""`. Next we will begin training our custom model. You are welcome to use any training images of your choosing, or to make things easier, we have included some sample training images in this github repo.

6. Navigate to the [Visual Recognition Tooling](https://watson-visual-recognition.ng.bluemix.net/) and enter your `api_key` to access your instance of Visual Recognition.

8. Select 'Create Classifier'

7. Select 'add class.' to add a new class or drop images into an existing class.  In your project directory there is a folder called 'training images.' Select or drag each image zip file to add image data. 

8. Specify class name for each zip file and select "Create" to create a new classifier.

9. Copy and paste the `classifierID` of the classifier created into the `classifiedId` variable.

10. Perform a clean build and run the project pointed to a device. 

11. Run the "Core ML Vision Custom" app on the device. 

12. Select or point to any image in the device or simulator. You should the image getting classified based on the labels you provided during training. 
