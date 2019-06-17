# Structure Example for Login-mandatory iOS Apps

This proves an example of how I would build an app which requires the user to login in order to function. It supports login/logout and could easily be expanded to handle signing up new users.

## Common points to modify:

### 1. API interactions.

If you're from the server team and need to correct a header or rename a field in JSON, the first place you would look is `UserManager.swift` and it's dependency `FakeAPI.swift`. Right now there's no actual server interaction, but you could add it in place of the `DispatchQueue` calls and nothing else in the app would know or care. Wether you wanted to have login information stored locally or make requests to a server, the app just expects that the `UserManager` has an asynchronous way to answer the questions an app needs: is a user logged in, is this a valid password for the user, etc.


### 2. Additional login/signup steps.

The entire login/signup process is handled by `AuthFlow.swift`. Any logic about which order steps should go in and which steps can be skipped goes here. Right now login is only two steps and registration is un-implemented. The `StageDecider` object is responsible for deciding the appropriate step based on context. This would be easy to test to make sure the user sees the right step depending on the user's context.

### 3. Main app UI

All UI for the actual app is displayed in `Main.storyboard` and looks about like you could expect any storyboard-based iOS app to look.

### 4. Auth UI

All UI for the auth flow is displayed in `Auth.storyboard`. Because the order of auth steps is unknown, each controller is not connected to the next, but the UI for each is what we intend to display to the user for each step.

### 5. Image and Color Assets

All images and important non-standard colors can be found in `Assets.xcassets`.
