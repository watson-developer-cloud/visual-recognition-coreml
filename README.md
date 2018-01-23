# Watson Core ML Starter Kit.
A repo containing the basics to get started classifying images using local Watson Visual Recognition models with Core ML. The included Xcode workspace contains two projects: [Core ML Vision Simple](#core-ml-vision-simple) and [Core ML Vision Custom Training](#core-ml-vision-custom-training).






## Before you begin
### Requirements
Ensure you have the following prerequisites:
1. An IBM Cloud account if you would like to run the [Core ML Vision Custom Training](#core-ml-vision-custom-training) project. If you don't have one, [sign up][ibm_cloud_registration].
1. [Xcode 9+][xcode_download].
1. iOS 11+.

### Getting the project
1. Download the project from GitHub. You can either clone the project or download it as a zip folder.

1. Open the workspace `QuickstartWorkspace.xcworkspace` in Xcode. You will see two projects. The first project ([Core ML Vision Simple](#core-ml-vision-simple)) is already pre-packaged with everything you need. It comes bundled with a base Watson Visual Recognition Model. The second project is set up to incorporate a custom Visual Recognition model. We will walk through the steps of creating your own model in [Core ML Vision Custom Training](#core-ml-vision-custom-training). 

### Provisioning an instance of Visual Recognition
For the [Core ML Vision Custom Training](#core-ml-vision-custom-training) you will need a Bluemix account and an `api_key` for an instance of the Watson Visual Recognition service. An instance of Visual Recognition is not required for [Core ML Vision Simple](#core-ml-vision-simple).
1. Click <a href="https://console.bluemix.net/registration/trial/?target=%2Fdeveloper%2Fwatson%2Fcreate-project%3Fservices%3Dwatson_vision_combined%26action%3Dcreate%26hideTours%3Dtrue" target="blank">here</a> to create an instance of the Visual Recognition service. You will need to create a bluemix account if you do not already have one.

1. Copy the `api_key` for the service instance for use in the [Core ML Vision Custom Training](#core-ml-vision-custom-training) project.






## Core ML Vision Simple
A basic implemenation of Watson Visual Recognition using Core ML.

1. In Xcode, ensure the active scheme is `Core ML Vision Simple`.

### Using the Simulator

2. Select an iPhone simulator target and click the play button to build and run the active scheme.
3. On the simulator, click the `camera` icon and select a photo from your photo library to classify. Note: You can add custom photos to the simulator by dragging them directly from the Finder to the simulator window.

### Using a device

2. Select the device to which you would like to publish the application. 
3. Select the target `Core ML Vision Simple`, under `Identity` choose a unique `Bundle Identifier` and under `Signing` select the team you would like use to sign the application.
4. Click the play button to build and run the active scheme on the device.
5. If the device shows an Untrusted Developer error, go to `Settings` > `General` > `Device Managment`. Select the team you used to sign the application and trust the profile.
6. On the device, click the `camera` icon and either take a photo of what you would like to classify (You will need to allow the application permissions to access the device camera) or select an image to be classified from your library. 






## Core ML Vision Custom Training
Watson Visual Recognition using Core ML, with the ability to train the base model and pull down updated versions. This guide will walk you through training a custom model on common cables (HDMI, USBC, etc.) and incorporating the custom model into your visual recognition application using the Watson Swift SDK

### Getting Started
1. You will need Carthage to download the Watson SDK framework, if you do not already have Carthage installed you can follow instructions [here](https://github.com/Carthage/Carthage#installing-carthage)

1. Download the latest SDK by opening your terminal, navigating to the Core ML Vision Custom/ directory and running the following command
```
carthage update
```
**Temporary Note:** Until the updates to the SDK are made public, you will need to download the development version of the SDK [here](https://github.ibm.com/watson-embed-partnerships/pluto-swift-sdk). Make sure that it is at the same level as this project in whatever directory you save this project in. You may need to periodically pull down updates from the SDK github when you pull down updates for this project.

1. After the package is done installing, you will find the Visual Recognition framework in the Carthage/Build/iOS directory. From this folder, drag `VisualRecognitionV3.framework` into your project's workspace, in the Core Ml Vision Custom\ directory. The Watson Swift SDK makes it easy to keep track of your custom Core ML models and pull down new versions of custom classifiers from the IBM Cloud and store them on your device.

1. Once you've dragged the framework into the workspace, go to the Core ML Vision Custom project settings by clicking on the project in the Project navigator. Under 'General,' scroll down to Embedded Binaries and click the '+' sign. Select the VisualRecognitionV3.framework.

1. Paste the `api_key` from obtained from [Provisioning an instance of Visual Recognition](#provisioning-an-instance-of-visual-recognition) to the top of the `ImageClassificationViewController.swift` file in your project, where it says `{api_key}`. 

### Training a custom model
Next we will begin training our custom model. You are welcome to use any training images of your choosing, or to make things easier, we have included some sample training images in this github repo.

1. Navigate to the [Visual Recognition Tooling][vr_tooling] and enter your `api_key` to access your instance of Visual Recognition.

1. Select `Create classifier`

1. Drop zip files of class images into an existing class or select `Add class.` to add a new class. In the project directory there is a folder called `training images` you can use to train a new classifier.

1. Specify class name describing each zip file and select "Create" to create a new classifier.

1. Copy and paste the `classifierID` of the classifier created into the `{classifier_id}` variable of `ImageClassificationViewController.swift`.

### Building and running
1. In Xcode, ensure the active scheme is `Core ML Vision Custom`.

#### Using the Simulator

2. Select an iPhone simulator target and click the play button to build and run the active scheme.
3. On the simulator, click the `camera` icon and select a photo from your photo library to classify. Note: You can add custom photos to the simulator by dragging them directly from the Finder to the simulator window.

#### Using a device

2. Select the device to which you would like to publish the application. 
3. Select the target `Core ML Vision Custom`, under `Identity` choose a unique `Bundle Identifier` and under `Signing` select the team you would like use to sign the application.
4. Click the play button to build and run the active scheme on the device.
5. If the device shows an Untrusted Developer error, go to `Settings` > `General` > `Device Managment`. Select the team you used to sign the application and trust the profile.
6. On the device, click the `camera` icon and either take a photo of what you would like to classify (You will need to allow the application permissions to access the device camera) or select an image to be classified from your library. 

[ibm_cloud_registration]: http://bluemix.net/registration
[xcode_download]: https://developer.apple.com/xcode/downloads/
[vr_tooling]: https://watson-visual-recognition.ng.bluemix.net/