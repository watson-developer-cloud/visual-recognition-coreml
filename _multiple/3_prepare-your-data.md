---
title: Prepare your data
date: 2018-01-03
---
In order to create our models, we have to provide training images to the classifier. For time's sake we have prepared the data for you.
![](assets/arduino_training_images.jpg)
Each class we create should have *at least* **10** images. However, for optimal training time and accuracy it's best to have around 200 images sized at 224 x 224 pixels. Also, it's good practice to have images from an environment comparable to what you expect to classify. For example, since this is an iOS app, photos from your smartphone camera are probably ideal, verses professional photos or image search results. Also, try and change the background, lighting, and any other variables that you can think of!

# Preparing our data
Download the [training image dataset](https://github.com/watson-developer-cloud/watson-vision-coreml-code-pattern/releases/download/3.1/arduino_training_images_small.zip), and unzip the contents to your desktop
