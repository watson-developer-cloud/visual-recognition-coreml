---
title: Deploy app to iOS device
date: 2018-04-09
---

1. Select the project editor (*The name of the project with a blue icon*)
1. Under the **Signing** section, click **Add Account**
![](assets/add_account.png)
1. Login with your Apple ID and password
![](assets/xcode_add_account.png)
1. *You should see a new personal team created*
1. Close the preferences window

Now we have to create a certificate to sign our app with
1. Select **General**
1. Change the **bundle identifier** to `com.ibm.watson.<YOUR_LAST_NAME>.coreML-demo`
![](assets/change_identifier.png)
1. Select the personal team that was just created from the **Team** dropdown
1. Plug in your iOS device
1. Select your device from the device menu to the right of the **build and run** icon
1. Click **build and run**
1. On your device, you should see the app appear as an installed appear
1. When you try to run the app the first time, it will prompt you to approve the developer
1. In your iOS settings navigate to ***General > Device Management***
1. Tap your email, tap **trust**

Now you're ready to run the app!
