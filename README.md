# Visual Recognition with Core ML

Classify images with [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/) and [Core ML](https://developer.apple.com/machine-learning/). The images are classified offline using a deep neural network that is trained by Visual Recognition.

This project includes the `QuickstartWorkspace.xcworkspace` workspace with two projects:

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

**Tip**: This project also includes a Core ML model to classify trees and fungi. You can switch between the two included Core ML models by uncommenting the model you would like to use in [ImageClassificationViewController](../master/Core%20ML%20Vision%20Simple/Core%20ML%20Vision%20Simple/ImageClassificationViewController.swift#L35-L39).

[Source code](../master/Core%20ML%20Vision%20Simple/Core%20ML%20Vision%20Simple/ImageClassificationViewController.swift) for `ImageClassificationViewController`.

## Running Core ML Vision Custom
This project trains a Visual Recognition model (also called a classifier) to identify common types of cables (HDMI, USB, etc.). Use the [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk) to download, manage, and execute the trained model. By using the Watson Swift SDK, you don't have to learn about the underlying Core ML framework.

### Setting up Visual Recognition in Watson Studio
1.  Log into [Watson Studio][watson_studio_visrec_tooling]. From this link you can create an IBM Cloud account, sign up for Watson Studio, or log in.
1.  After you sign up or log in, you'll be on the Visual Recognition instance overview page in Watson Studio.

### Training the model
1.  In Watson Studio on the Visual Recognition instance overview page, click **Create Model** in the Custom box.
1.  If a project is not yet associated with the Visual Recognition instance you created, a project is created. Name your project 'Custom Core ML' and click the **Create**. 

    **Tip**: If no storage is defined, click **refresh**.
1.  Upload each .zip file of sample images from the `Training Images` directory onto the data panel. Add the `hdmi_male.zip` file to your model by clicking the **Browse** button in the data panel. Also add the `usb_male.zip`, `thunderbolt_male.zip`, `vga_male.zip` file to your model.
1.  After the files are uploaded, select **Add to model** from the menu next to each file, and then click **Train Model**.

### Copy your Model ID and API Key
1.  In Watson Studio on the custom model overview page, click your Visual Recognition instance name (it's next to Associated Service). 
1.  Scroll down to find the **Custom Core ML** classifier you just created. 
1.  Copy the **Model ID** of the classifier.
1.  In the Visual Recognition instance overview page in Watson Studio. Click the **Credentials** tab, and then click **View credentials**. Copy the `api_key` of the service.

### Adding the classifierId and apiKey to the project
1.  Open the project in XCode.
1.  Copy the **Model ID** and paste it into the **classifierID** property in the [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) file.
1.  Copy your **api_key** and paste it into the **apiKey** property in the [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) file.

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

    **Tip:** The classifier status must be `Ready` to use it. Check the classifier status in Watson Studio on the Visual Recognition instance overview page.

[Source code](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift) for `ImageClassificationViewController`.

## What to do next

Add another Watson service to the custom project with the [Core ML Visual Recognition with Discovery][vizreq_with_discovery] project.

## Resources

- [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/)
- [Watson Visual Recognition Tool][vizreq_tooling]
- [Apple machine learning](https://developer.apple.com/machine-learning/)
- [Core ML documentation](https://developer.apple.com/documentation/coreml)
- [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk)
- [IBM Cloud](https://bluemix.net)

[vizreq_with_discovery]: https://github.com/watson-developer-cloud/visual-recognition-with-discovery-coreml/
[xcode_download]: https://developer.apple.com/xcode/downloads/
[vizreq_tooling]: https://dataplatform.ibm.com/registration/stepone?context=wdp&apps=watson_studio&target=watson_vision_combined
[watson_studio_visrec_tooling]: https://dataplatform.ibm.com/registration/stepone?target=watson_vision_combined&context=wdp&apps=watson_studio&cm_sp=WatsonPlatform-WatsonPlatform-_-OnPageNavCTA-IBMWatson_VisualRecognition-_-CoreMLGithub
