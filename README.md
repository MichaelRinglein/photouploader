# Photouploader

Photouploader for Android and iOS. It's possible to sign in , select an image from the gallery of the phone and upload it to a cloud. It's not possible to upload without prior sign in.


## In Detail

Sign up / login:

User can sign in via Firebase Auth. Available Sign in methods are anonym or with a Google account.

Logout:

User can simply log out and is redirected back to the authentication screen.

Select image:

Image picker can access either the camera or the gallery. In this app I chose to access the gallery only.


Delete image:

The image can be also deleted.


Show all my images:

Does nothing yet but is extendable.

Upload:

The image can be uploaded to a Firebase storage. It's sorted there in folder containing the User ID from signing in (in order to extend the app later by being able to assign images to users).


## Packages used

[Image Picker](https://pub.dev/packages/image_picker)
[Firebase Core](https://pub.dev/packages/firebase_core)
[Firebase Auth](https://pub.dev/packages/firebase_auth)
[Firebase Storage](https://pub.dev/packages/firebase_storage)
[Google Signin](https://pub.dev/packages/google_sign_in)
[Provider](https://pub.dev/packages/provider)
[Spinkit](https://pub.dev/packages/flutter_spinkit)


