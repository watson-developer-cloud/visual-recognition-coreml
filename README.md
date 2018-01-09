# Watson Core ML Starter Kit.
## This is an Xcode workspace that contains the following two projects
* Core ML Vision Simple
* Core ML Vision Custom Training

## Core ML Vision Simple
A basic implemenation of Watson Visual Recognition using Core ML.
### Getting Started
1. Download project from GitHub. You can either clone the project or download it as a zip folder.

2. Open workspace (QuickstartWorkspace.xcworkspace) in Xcode

3. You will see two projects. The first project (Core ML Vision Simple) is already pre-packaged with everything you need. It comes bundled with a base Watson Visual Recognition Model. The second project is set up to incorporate a custom Visual Recognition model. We will bring you through the steps of creating your own model in the next section. 

4. If you hit run, you can launch the first project and start classifying images immediately. Click the camera icon to choose photo to classify.

## Core ML Vision Custom Training
Watson Visual Recognition using Core ML, with the ability to train the base model and pull down updated versions. This guide will walk you through training a custom model on common cables (HDMI, USBC, etc.) and incorporating the custom model into your visual recognition application using the Watson SDK

### Getting Started

1. You will need Carthage to download the Watson SDK framework, if you do not already have Carthage installed you can follow instructions [here](https://github.com/Carthage/Carthage#installing-carthage)

2. Once Carthage is set up, you can download the latest SDK by opening your terminal, navigating to the Core ML Vision Custom/ directory and running the following command
```
carthage update
```
**Temporary Note:** Until the updates to the SDK are made public, you will need to download the development version of the SDK [here](https://github.ibm.com/watson-embed-partnerships/pluto-swift-sdk). Make sure that it is at the same level as this project in whatever directory you save this project in. You may need to periodically pull down updates from the SDK github when you pull down updates for this project.


3. After the package is done installing, you will find the Visual Recognition framework in the Carthage/Build/iOS directory. From this folder, drag `VisualRecognitionV3.framework` into your project's workspace, in the Core Ml Vision Custom\ directory. The Watson SDK makes it easy to keep track of your custom Core ML models and pull down new versions of custom classifiers from the IBM Cloud and store them on your device.

4. Once you've dragged the framework into the workspace, go to the Core ML Vision Custom project settings by clicking on the project in the Project navigator. Under 'General,' scroll down to Embedded Binaries and click the '+' sign. Select the VisualRecognitionV3.framework.

5. Next you will need to go to bluemix and provision a free instance of Visual recognition. Click [this](https://console.bluemix.net/registration/trial/?target=%2Fdeveloper%2Fwatson%2Fcreate-project%3Fservices%3Dwatson_vision_combined%26action%3Dcreate%26hideTours%3Dtrue) link to do so. You will need to create a bluemix account if you do not already have one.

6. On this page you can copy your `api_key` from the listed credentials and paste it at the top of the `ImageClassificationViewController.swift` file in your project, where it says `apiKey = ""`. Next we will begin training our custom model. You are welcome to use any training images of your choosing, or to make things easier, we have included some sample training images in this github repo.

7. On the page where you got your credentials, open the Visual Recogniton tooling by clicking the launch tool button.

8. Select 'Create Classifier'

9. Select 'add data.' In your project directory there is a folder called 'training images.' Select all of the images from this folder.

