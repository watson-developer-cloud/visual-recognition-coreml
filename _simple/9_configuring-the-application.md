---
title: Configuring the application
date: 2018-01-09
---

1. Open the project directory in finder. You can do this with the following command
   ```bash
   open .
   ```
1. Then double click the `Core ML Vision Custom.xcodeproj` file to open the project in Xcode
![](../images/step_9_open_project.png)
1. In Watson Studio, make your way back to your project's **Assets** tab.
![](../images/9_1_project_assets.png)
1. Then open your model and copy your **ModelID**. Keep it handy for later.
![](../images/9_2_model_id.png)
1. Open the associated visual recognition service.
![](../images/9_3_associated_service.png)
1. Navigate to the **Credentials** tab.
![](../images/9_4_credentials.png)
1. Copy your **"apikey"** and keep it handy for later.
![](../images/9_5_api_key.png)
1. Open the file called `ImageClassificationViewController.swift` and add your ModelID.
![](../images/step_9_add_model_id.png)
1. Next, in the same file, add your api key.
![](../images/step_9_add_api_key_single_model.png)
