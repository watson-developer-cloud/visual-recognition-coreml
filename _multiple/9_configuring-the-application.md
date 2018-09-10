---
title: Configuring the application
date: 2018-01-09
---

1. Open the project directory in finder. You can do this with the following command
   ```bash
   open .
   ```
1. Then double click the `Core ML Vision Custom.xcodeproj` file to open the project in Xcode
![](assets/step_9_open_project.png)
1. In Watson Studio, make your way back to your project's **Assets** tab.
![](assets/arduino_data_assets_list.png)
1. Then open your model and copy your **ModelID**s. Keep them handy for later.
![](assets/arduino_model_id.png)
1. Open the associated visual recognition service.
![](assets/arduino_associated_service.png)
1. Navigate to the **Credentials** tab.
![](assets/arduino_credentials.png)
1. Copy your **"apikey"** and keep it handy for later.
![](assets/arduino_api_key.png)
1. Open the file called `ImageClassificationViewController.swift` and add your ModelIDs.
![](assets/step_9_add_model_ids.png)
1. Next, in the same file, add your api key.
![](assets/step_9_add_api_key.png)
