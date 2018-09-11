---
title: Configuring the application
date: 2018-04-06
---

Once your classifier is done training, we can  prepare our iOS application to run.

1. Navigate back to the app console and click **Download Code**
![](../_images/console_launch_tool.png)
1. Unzip the code
1. From *Launchpad* search for `terminal` and click the icon to open the application
![](../_images/launchpad_terminal.png)
1. Change into the project directory with the following command ***Note: In OS X, you can drag the folder in to the terminal and the path will automatically be inserted***
```bash
cd Downloads/ConnectorsVisionModelforCoreMLwithWatson-Swift
```
![](../_images/console_cd_app.png)
1. Install the CocoaPods libraries
```bash
pod update
```
![](../_images/console_pod_update.png)
1. Install the Carthage dependancies
```bash
carthage update --platform iOS
```
![](../_images/console_cart_update.png)
1. Once the dependancies are all installed, open the folder and open the `ConnectorsVisionModelforCoreMLwithWatson.xcworkspace` file
