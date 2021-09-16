
## Problem description
[PDF](https://github.com/Joule87/Media/blob/master/PizzaBot/Slice_Code_Challenge.pdf)

## Technologies used
The app is written in Swift 5, with Xcode 12.2, UIKit as the ui framework, unit testing is done with the native tools provided by XCode

## How to run
Open PizzaBot.xcodeproj select target PizzaBot and select device/simulator, then run.
In order to run tests, on the left side open test navigator panel and run all the tests, on the reports tab the coverage can be seen.

## How to use
Al instructions should comply with format 5x5 (0,0) (1,3) (4,4) (4,2) (4,2). 5x5 makes reference to the dimensions of the grid and (0,0) (1,3) (4,4) (4,2) (4,2) are the delivery points.
You can execute this instruction clicking Execute button or pressing the phone keyboard "return" button. Is you turn on "Optimize Delivery switch" the bot will take the optimal route to navigate between locations

## PizzaBot output meaning
* N: move north
* E: move east
* S: move south
* O: move west
* D: deliver

## Sample
Instruction: "4x4 (1,3) (1,2)"
* Not Optimized output: ENNNDSD
* Optimized output: ENNDND

## Architecture choose
For this small project the native MVC architecture is perfect, it's the simplest architecture pattern, also the native approach promoted by Apple.

## Project structure 
* PizzaBot: Contains the main app code
    * Util: contains small helper classes, constants and extensions.
    * Resources: contains the apps resources (images, config files)
    * Launch: App init managers
    *  Delivery
        * View: contains custom UIViews, storyboards and table cells
        * Model: contains the apps models
        * Controller: contains the view controllers
* ImageViewerTests: Contains the unit tests

Note: Project was structured based on screaming architecture approach.

## Errors from user perspective
When processing an instruction, if an error occurs a warning message will appear under input field showing a message related to the current error

## unit tests
The unit tests are focused on the logic. They don't test anything on view controllers or views.
