# TestBirdProto

## Appium installation:
- Install brew
- Install node
- Install Appium
- Install appium-doctor
- Install Xcode command line tools (xcode-select --install)
- Install carthage (brew install carthage)
- Set up the system for real device: http://appium.io/docs/en/drivers/ios-xcuitest-real-devices/
- brew install libimobiledevice


## Installations

After cloning don't forget to install cocoapods in the project directory from the terminal: $ pods install 

## Using the prototype
Currently only iPhone devices supported, minimum iOS version: 10, not all of the iOS portfolio (iPads are not).
The default values for the capabilities are like the placeholders in the textfileds.

For accomplish a connection and start the app, fist start the Appium (for example from Terminal: $ appium), and press Connect to Appium server session.

If the connection is OK, the refresh screenshot button should work.
