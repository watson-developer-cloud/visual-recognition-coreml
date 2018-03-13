# Visual Recognition with Core ML starter kit

Classify images with [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/) and [Core ML](https://developer.apple.com/machine-learning/). The images are classified offline using a deep neural network that is trained by Visual Recognition.

This starter kit includes the `QuickstartWorkspace.xcworkspace` workspace with two projects:

- **Core ML Vision Simple**: Classify images locally with Visual Recognition.
- **Core ML Vision Custom**: Train a custom Visual Recognition model for more specialized classification.

## Before you begin

Make sure that you have installed [Xcode 9][xcode_download] or later and iOS 11.0 or later. These versions are required to support Core ML.

## Getting the files
Use GitHub to clone the repository locally, or download the .zip file of the repository and extract the files.

## Running Core ML Vision Simple
Identify common objects with a built-in Visual Recognition model. Images are classified with the [Core ML](https://developer.apple.com/documentation/coreml) framework.

1.  Open `QuickstartWorkspace.xcworkspace` in Xcode.
1.  Select the `Core ML Vision Simple` scheme.
1.  Run the application in the simulator or on your device.
1.  Classify an image by clicking the camera icon and selecting a photo from your photo library. To add a custom image in the simulator, drag the image from the Finder to the simulator window.

[Source code](../master/Core%20Ml%20Vision%20Simple/Core%20Ml%20Vision%20Simple/ImageClassificationViewController.swift) for `ImageClassificationViewController`.

## Running Core ML Vision Custom
This project trains a Visual Recognition model (also called a classifier) to identify common types of cables (HDMI, USB, etc.). Use the [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk) to download, manage, and execute the trained model. By using the Watson Swift SDK, you don't have to learn about the underlying Core ML framework.

## Setting up Visual Recognition in Watson Studio
1.  Click [here][watson_studio_visrec_tooling] to access Watson Studio.
1.  Sign in to Studio and create an **IBM Cloud account** if you don't have one. 
    *   If you already have an IBM Cloud account, click the link to *Use it to sign up for IBM Data Platform* and skip to step 3. 
    *   If you already have both an IBM Cloud account and an IBM Studio account, click *Sign in*. and skip to step 3. 
    *   If you don't have an IBM Cloud account, *Create your IBM Cloud Account* by entering your email address and clicking the *Next* button. Complete the form and click *Create Account*. Check your email to confirm your account.
1.  In Watson Studio you should be in your Visual Recognition instance overview page. Click on the *Credentials* tab and click *View credentials* for the Visual Recognition service instance. Copy the `api_key` of the service.
1.  Click the *Overview* tab. Under "Custom" click the *Create Model* button.
1.  Name your project and give it a description. Click the *Create* button to create your project.
1.  Enter "Custom Core ML" for your model name.
1.  Upload each .zip file of sample images from the Training Images directory onto the data panel. 
1.  Add the `hdmi_male.zip` file to your model from the data panel.
1.  Add the `usb_male.zip` file to your model.
1.  Click *Train Model*.
1.  Click on your project name on the top left of the screen. Copy the `Model ID` of the custom model you just trained.
1.  Copy the classifier ID and paste it into the **classifierID** property in the [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) file.
1.  Copy your API Key and paste it into the **apiKey** property in the [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) file.

### Downloading the Watson Swift SDK
Use the Carthage dependency manager to download and build the Watson Swift SDK.

1.  Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage).
1.  Open a terminal window and navigate to the `Core ML Vision Custom` directory.
1.  Run the following command to download and build the Watson Swift SDK:

    ```bash
    carthage bootstrap --platform iOS
    ```
1.  In Xcode, use the **Project Navigator** to select the `Core ML Vision Custom` project.
1.  In the General settings tab, scroll down to **Embedded Binaries** and click the `+` icon.
1.  Click **Add Other**, navigate to the `Carthage/Build/iOS` directory, and select **VisualRecognitionV3.framework**.

**Tip:** Regularly download updates of the SDK so you stay in sync with any updates to this project.

### Testing the custom model

1. Open `QuickstartWorkspace.xcworkspace` in Xcode.
1. Select the `Core ML Vision Custom` scheme.
1. Run the application in the simulator or on a device.
1. Classify an image by clicking the camera icon and selecting a photo from your photo library. To add a custom image in the simulator, drag the image from the Finder to the simulator window.
1. Pull new versions of the visual recognition model with the refresh button in the bottom right.

[Source code](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) for `ImageClassificationViewController`.

## What to do next

Add another Watson service to the custom project with the [Core ML Visual Recognition with Discovery][vizreq_with_discovery] starter kit.

## Resources

- [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/)
- [Watson Visual Recognition Tool][vizreq_tooling]
- [Apple machine learning](https://developer.apple.com/machine-learning/)
- [Core ML documentation](https://developer.apple.com/documentation/coreml)
- [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk)
- [IBM Cloud](https://bluemix.net)

[vizreq_with_discovery]: https://github.com/watson-developer-cloud/visual-recognition-with-discovery-coreml/
[xcode_download]: https://developer.apple.com/xcode/downloads/
[vizreq_tooling]: https://watson-visual-recognition.ng.bluemix.net/
[watson_studio_visrec_tooling]: https://dataplatform.ibm.com/registration/stepone?context=wdp&target=watson_vision_combined&apps=data_science_experience
