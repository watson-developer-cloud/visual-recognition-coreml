---
title: Creating a model
date: 2018-01-07
---
The next part of the process is creating your very own custom visual recognition model.

You can create a model by either going to assets and pressing **New visual recognition model** under **Visual recognition models**.

Or by pressing the **Add to project** dropdown from anywhere in your project and choosing **Visual recognition model**.

![](assets/data_assets_add_model.png)

When you create a new model you should automatically be directed to the models training area.  If you need to find your way back to this page you can do so by navigating to your project *(Projects > My First Project)* then under the **Assets** tab click on your model under the **Visual recognition models** section.

![](assets/add_assets_screen.png)

Create a new class for each *type* of Arduino part. Specifically, create a class for "Mega", then "Uno", and finally create a "Negative" class.

![](assets/add_assets_screen_empty_classes.png)

Then drag and drop the zip files from the side panel onto the corresponding class.

![](assets/add_images_to_class.png)

![](assets/images_added_to_class.png)

After all your classes are complete, you are ready to train your model. Just press the **Train Model** button.

![](assets/train_model_part.png)

Training time can vary depending on the amount of training data. A good rule of thumb is a few seconds per image. Since we have around 200 images, we can expect the model to take about 5–10 minutes to train.

Repeat the above steps for the second model of Arduino faults. Specifically, create a class for "Capacitor Failed", then "Normal", and finally create a "Negative" class.

![](assets/train_model_fault.png)

In the meantime we can start preparing the iOS app.
