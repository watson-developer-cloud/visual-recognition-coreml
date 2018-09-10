---
title: Getting the code
date: 2018-01-08
---

1. From *Launchpad* search for `terminal` and click the icon to open the application
![](assets/launchpad_terminal.png)
1. Clone the project with the following command
```bash
git clone https://github.com/watson-developer-cloud/visual-recognition-coreml.git
```
![](assets/terminal_clone_repo_start.png)
1. Change into the project directory with the following command
```bash
cd visual-recognition-coreml/Core\ ML\ Vision\ Custom
```
![](assets/terminal_clone_repo_finished.png)
1. Now we will gather the Watson SDK by executing the following command:
```bash
carthage bootstrap --platform iOS
```
![](assets/terminal_carthage.png)
