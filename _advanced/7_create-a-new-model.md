---
title: Creating a model
date: 2018-01-07
---
The next part of the process is creating your very own custom visual recognition model.

You can create a model by either going to assets and pressing **New visual recognition model** under **Visual recognition models**.

Or by pressing the **Add to project** dropdown from anywhere in your project and choosing **Visual recognition model**.

![](https://cdn-images-1.medium.com/max/6208/1*bFq2m7N_GV7ahJhb640WPw.png)

When you create a new model you should automatically be directed to the models training area.  If you need to find your way back to this page you can do so by navigating to your project *(Projects > My First Project)* then under the **Assets** tab click on your model under the **Visual recognition models** section.

![](https://cdn-images-1.medium.com/max/6208/1*wptStjboOq4k_9xrt5qeFA.png)

Create a new class for each *type* of connector.

![](https://cdn-images-1.medium.com/max/6208/1*-AJ7d3V8DNKCGDqB3Uww8Q.png)

Then drag and drop the zip files from the side panel onto the corresponding class.

![](https://cdn-images-1.medium.com/max/6208/1*icXxT4vrw9mZFQKgXY0pMA.png)

![](https://cdn-images-1.medium.com/max/6208/1*-7NPuCWFQFI30QXgvx4cgg.png)

After all your classes are complete, you are ready to train your model. Just press the **Train Model** button.

![](https://cdn-images-1.medium.com/max/6208/1*p1Q5JyTMQvUSa78Z1gtYhg.png)

Training time can vary depending on the amount of training data. A good rule of thumb is a few seconds per image. Since we have around 200 images, we can expect the model to take about 5–10 minutes to train.

In the meantime we can start preparing the iOS app.
