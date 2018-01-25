# Starter Kit: Watson Visual Recognition with Core ML

This repository demonstrates how to classify images using [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/) and [Core ML](https://developer.apple.com/machine-learning/). Images are classified offline using a deep neural network trained by Visual Recognition.

## Contents

* [Requirements](#requirements)
* [Project Setup](#project-setup)
* [Example: Core ML Vision Simple](#example-core-ml-vision-simple)
* [Example: Core ML Vision Custom Training](#example-core-ml-vision-custom-training)
* [Resources](#resources)

## Requirements

Xcode 9.0+ and iOS 11.0+ are required to support Core ML.

A Visual Recognition instance is also required by the [Core ML Vision Custom Training](#example-core-ml-vision-custom-training) example:

1. Create an [IBM Cloud](https://bluemix.net) account.
2. Create a service instance by clicking <a href="https://console.bluemix.net/registration/trial/?target=%2Fdeveloper%2Fwatson%2Fcreate-project%3Fservices%3Dwatson_vision_combined%26action%3Dcreate%26hideTours%3Dtrue" target="blank">here</a>.
3. Click "Show" to reveal the service credentials.
4. Copy the `api_key` for use with the [Core ML Vision Custom Training](#example-core-ml-vision-custom-training) example.
    
## Project Setup

1. Download the project from GitHub. You can either clone the project or download it as a zip folder.

1. Open the workspace `QuickstartWorkspace.xcworkspace` in Xcode. You will see two projects. The first project ([Core ML Vision Simple](#example-core-ml-vision-simple)) is already pre-packaged with everything you need. It comes bundled with a base Watson Visual Recognition Model. The second project is set up to incorporate a custom Visual Recognition model. We will walk through the steps of creating your own model in [Core ML Vision Custom Training](#example-core-ml-vision-custom-training). 

## Example: Core ML Vision Simple

This example uses a Visual Recognition classifier to identify common objects. Images are classified using the [Core ML](https://developer.apple.com/documentation/coreml) framework. A trained model is already included in the project, making it easy to get up-and-running.

1. Clone the repository or download it as a zip file.
2. Open `QuickstartWorkspace.xcworkspace` in Xcode.
3. Select the `Core ML Vision Simple` scheme.
4. Run the application in the simulator or on a device.
5. To classify an image, click the camera icon and select a photo from your photo library. To add custom images in the simulator, drag-and-drop the image file from Finder to the simulator window.

The source code for this example can be found in [`ImageClassificationViewController`](../master/Core%20Ml%20Vision%20Simple/Core%20Ml%20Vision%20Simple/ImageClassificationViewController.swift).

## Example: Core ML Vision Custom Training

This example trains a Visual Recognition classifier to identify common types of cables (HDMI, USB, etc.). The [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk) is used to download, manage, and execute the trained model. With the Watson Swift SDK, you can get up-and-running without having to learn the underlying Core ML framework.

### Train a Custom Model

We will use the [Visual Recognition Tooling][vr_tooling] to upload images and train a custom classifier. We have included sample images in this repository, but you are welcome to use any training images you like.

1. Open the [Visual Recognition Tooling][vr_tooling].
2. Enter the `api_key` for your Visual Recognition instance.
3. Select "Create Classifier."
4. Drag-and-drop each zip file of images from the [Training Images](../master/Training%20Images) directory onto a class.
5. Provide class names of "HDMI" and "USB".
6. Click "Create" to create a new classifier.
7. Copy and paste the classifier ID into the `classifierID` property in [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift).
8. Copy and paste your service instance's API Key into the `apiKey` property in [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift).

### Download Watson Swift SDK

We will use the Carthage dependency manager to download and build the Watson Swift SDK.

1. [Install Carthage](https://github.com/Carthage/Carthage#installing-carthage).
2. Open a terminal and navigate to the `Core ML Vision Custom` directory.
3. Run `carthage bootstrap --platform iOS` to download and build the Watson Swift SDK.
4. In Xcode, use the Project Navigator to select the `Core ML Vision Custom` project.
5. In the "General" settings tab, scroll down to Embedded Binaries and click the "+" icon.
6. Click "Add Other", navigate to the `Carthage/Build/iOS` directory, and select `VisualRecognitionV3.framework`.

**Temporary Note:** Until the updates to the SDK are made public, you will need to download the development version of the SDK [here](https://github.ibm.com/watson-embed-partnerships/pluto-swift-sdk). Make sure that it is at the same level as this project in whatever directory you save this project in. You may need to periodically pull down updates from the SDK github when you pull down updates for this project.

### Run the Example App

1. Open `QuickstartWorkspace.xcworkspace` in Xcode.
2. Select the `Core ML Vision Custom` scheme.
3. Run the application in the simulator or on a device.
4. To classify an image, click the camera icon and select a photo from your photo library. To add custom images in the simulator, drag-and-drop the image file from Finder to the simulator window.

The source code for this example can be found in [`ImageClassificationViewController`](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift).

## Resources

- [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/)
- [Watson Visual Recognition Tooling][vr_tooling]
- [Apple Machine Learning](https://developer.apple.com/machine-learning/)
- [Core ML Documentation](https://developer.apple.com/documentation/coreml)
- [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk)
- [IBM Cloud](https://bluemix.net)

[ibm_cloud_registration]: http://bluemix.net/registration
[xcode_download]: https://developer.apple.com/xcode/downloads/
[vr_tooling]: https://watson-visual-recognition.ng.bluemix.net/
