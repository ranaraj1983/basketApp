# basketapp

A new Flutter application.

command

flutter pub run build_runner build

https://ptyagicodecamp.github.io/loading-image-from-firebase-storage-in-flutter-app-android-ios-web.html
https://github.com/ptyagicodecamp/flutter_cookbook/tree/widgets/flutter_widgets


service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}



