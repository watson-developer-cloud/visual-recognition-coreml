*阅读本文的其他语言版本：[English](README.md)。*

# 支持 Core ML 的 Visual Recognition

利用 [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/) 和 [Core ML](https://developer.apple.com/machine-learning/) 对图像进行分类。使用经由 Visual Recognition 训练的深度神经网络脱机对图像进行分类。

此项目包含 `QuickstartWorkspace.xcworkspace` 工作空间，其中含有以下两个项目：

- **Core ML Vision Simple**：利用 Visual Recognition 在本地对图像进行分类。
- **Core ML Vision Custom**：训练自定义 Visual Recognition 模型，实现更专业化的分类。

## 准确工作

确保已安装 [Xcode 9][xcode_download] 或更高版本以及 iOS 11.0 或更高版本。这些是支持 Core ML 所必需的版本。

## 获取文件
使用 GitHub 在本地克隆存储库，或者下载存储库的 .zip 文件并解压缩这些文件。

## 运行 Core ML Vision Simple
通过内置的 Visual Recognition 模型识别常见物体。使用 [Core ML](https://developer.apple.com/documentation/coreml) 框架对图像进行分类。

1.  在 Xcode 中打开 `QuickstartWorkspace.xcworkspace`。
1.  选择 `Core ML Vision Simple` 模式。
1.  在模拟器或者您的设备上运行应用。
1.  通过点击照相机图标并从照片库中选择照片，对图像进行分类。要将自定义图像添加到模拟器中，请将图像从 Finder 拖到模拟器窗口中。

**提示**：此项目还包含一个 Core ML 模型，用于对树和真菌进行分类。通过对要在 [ImageClassificationViewController](../master/Core%20ML%20Vision%20Simple/Core%20ML%20Vision%20Simple/ImageClassificationViewController.swift#L35-L39)中使用的模型取消注释，即可在所包含的两个 Core ML 模型之间进行切换。

`ImageClassificationViewController` 的[源代码](../master/Core%20ML%20Vision%20Simple/Core%20ML%20Vision%20Simple/ImageClassificationViewController.swift)。

## 运行 Core ML Vision Custom
此项目的第二部分是在第一部分的基础上构建的，可对 Visual Recognition 模型（也称为分类器）进行训练，以识别常见电缆类型（HDMI、USB 等）。使用 [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk) 来下载、管理和执行经过训练的模型。通过使用 Watson Swift SDK，您完全不必了解底层 Core ML 框架。

### 在 Watson Studio 中设置 Visual Recognition
1.  登录 [Watson Studio][watson_studio_visrec_tooling]。通过此链接，您可以创建一个 IBM Cloud 帐户、注册 Watson Studio 或进行登录。
1.  注册或登录后，将进入 Watson Studio 中的 Visual Recognition 实例概述页面。

    **提示**：如果在以下任一步骤中迷失方向，请单击页面左上角的 `IBM Watson` 徽标，以转至 Watson Studio 主页。在该主页上，可通过单击“Watson services”下相应服务旁的 **Launch tool** 按钮，访问自己的 Visual Recognition 实例。

### 训练模型
1.  在 Watson Studio 中的 Visual Recognition 实例概述页面上，单击 Custom 框中的 **Create Model**。
1.  如果尚未将任何项目与您创建的 Visual Recognition 实例关联，将会创建一个项目。请将项目命名为 `Custom Core ML`，然后单击 **Create**。 

    **提示**：如果未定义存储，请单击 **refresh**。
1.  将每个样本图像 .zip 文件从 `Training Images` 目录上传至页面右侧的数据窗格中。单击数据窗格中的 **Browse** 按钮，将 `hdmi_male.zip` 文件添加到模型中。同时将 `usb_male.zip`、`thunderbolt_male.zip` 和 `vga_male.zip` 文件添加到模型中。
1.  上传这些文件后，从每个文件旁的菜单中选择 **Add to model**，然后单击 **Train Model**。

### 复制模型 ID 和 API 密钥
1.  在 Watson Studio 中的自定义模型概述页面上，单击 Visual Recognition 实例名称（位于 Associated Service 旁）。 
1.  向下滚动以查找刚才创建的 **Custom Core ML** 分类器。 
1.  复制分类器的 **Model ID**。
1.  在 Watson Studio 中的 Visual Recognition 实例概述页面上，单击 **Credentials** 选项卡，然后单击 **View credentials**。复制服务的 `api_key`。

### 将 classifierId 和 apiKey 添加到项目中
1.  在 XCode 中打开项目。
1.  复制 **Model ID**，并将其粘贴到 [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift)文件的 **classifierID** 属性中。
1.  复制 **api_key**，并将其粘贴到 [ImageClassificationViewController](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift)文件的 **apiKey** 属性中。

### 下载 Watson Swift SDK
使用 Carthage 依赖关系管理器来下载和构建 Watson Swift SDK。

1.  安装 [Carthage](https://github.com/Carthage/Carthage#installing-carthage)。
1.  打开终端窗口，浏览至 `Core ML Vision Custom` 目录。
1.  运行以下命令以下载和构建 Watson Swift SDK：

    ```bash
    carthage bootstrap --platform iOS
    ```

**提示：** 定期下载 SDK 更新，以便与此项目的任何更新保持同步

### 测试自定义模型

1. 在 Xcode 中打开 `QuickstartWorkspace.xcworkspace`。
1. 选择 `Core ML Vision Custom` 模式。
1. 在模拟器或者设备上运行应用。
1. 通过点击照相机图标并从照片库中选择照片，对图像进行分类。要将自定义图像添加到模拟器中，请将图像从 Finder 拖到模拟器窗口中。
1. 通过右下角的 Refresh 按钮，拉取新版本的 Visual Recognition 模型。

    **提示：** 分类器状态必须为 `Ready` 才能使用。请在 Watson Studio 中的 Visual Recognition 实例概述页面上检查分类器状态。

`ImageClassificationViewController` 的[源代码](../master/Core%20ML%20Vision%20Custom/Core%20ML%20Vision%20Custom/ImageClassificationViewController.swift)。

## 后续步骤

通过 [Core ML Visual Recognition with Discovery][vizreq_with_discovery] 项目，向自定义项目添加另一个 Watson 服务。

## 资源

- [Watson Visual Recognition](https://www.ibm.com/watson/services/visual-recognition/)
- [Watson Visual Recognition 工具][vizreq_tooling]
- [Apple 机器学习](https://developer.apple.com/machine-learning/)
- [Core ML 文档](https://developer.apple.com/documentation/coreml)
- [Watson Swift SDK](https://github.com/watson-developer-cloud/swift-sdk)
- [IBM Cloud](https://bluemix.net)

[vizreq_with_discovery]: https://github.com/watson-developer-cloud/visual-recognition-with-discovery-coreml/
[xcode_download]: https://developer.apple.com/xcode/downloads/
[vizreq_tooling]: https://dataplatform.ibm.com/registration/stepone?context=wdp&apps=watson_studio&target=watson_vision_combined
[watson_studio_visrec_tooling]: https://dataplatform.ibm.com/registration/stepone?target=watson_vision_combined&context=wdp&apps=watson_studio&cm_sp=WatsonPlatform-WatsonPlatform-_-OnPageNavCTA-IBMWatson_VisualRecognition-_-CoreMLGithub
