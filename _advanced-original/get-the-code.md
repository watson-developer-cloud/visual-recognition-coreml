---
title: Getting the code
date: 2018-04-03
---

1. From *Launchpad* search for `terminal` and click the icon to open the application
![](assets/launchpad_terminal.png)
1. Clone the project with the following command
```bash
git clone https://github.com/watson-developer-cloud/visual-recognition-with-discovery-coreml.git
```
![](assets/terminal_git_clone.png)
1. Change into the project directory with the following command
```bash
cd visual-recognition-with-discovery-coreml
```
![](assets/terminal_cd_proj.png)
1. Now we will gather the Watson SDK by executing the following command:

```bash
carthage bootstrap --platform iOS
```
![](assets/terminal_carthage_bootstrap.png)
