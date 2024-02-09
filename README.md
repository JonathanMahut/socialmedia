# Tatoo Connect Social Media App  

Tatoo Connect is a fully functional social media app with multiple features built with flutter and dart.

The objective is to permits to Tatoo Artists, Announcers and Evnts organisator to publish their workd ans to Client to see the differents posts, comments them, like them, follow artist and Studio, Events, and choose some Tatoo Flash as we choose a Love Partner to be in contact with the Tatoo Artist.


## Requirements

* Any Operating System (ie. MacOS X, Linux, Windows)
* Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
* A little knowledge of Dart 3.x and Flutter
* A brain to think

## Features

* Custom photo feed
* Post photo posts from camera or gallery
  * Like posts
  * Comment on posts
    * View all comments on a post
* Search for users
* Realtime Messaging and Sending images
* Deleting Posts
* Profile Pages
  * Change profile picture
  * Change username
  * Follow / Unfollow Users
  * Change image view from grid layout to feed layout
  * Add your own bio
* Notifications Feed showing recent likes / comments of your posts + new followers
* Swipe to delete notification
* Dark Mode Support
* Stories/Status
* Used Provider to manage state

## Screenshots


</p>

## Installation

#### 1. [Setup Flutter](https://flutter.dev/docs/get-started/install)

2. Setup Firebase CLI

#### 3. Setup the firebase app

- You'll need to create a Firebase instance. Follow the instructions
  at https://console.firebase.google.com.
- Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Email and Password" and enable it
* You'll need to create a Firestore Database and a Firebase Storage

```
FlutterFire configure and answer to the différents question
```

* The google.service.json and firebase needed diles will be automacality created
* For android, some modifications will be to done in the gradle file (project and app).)
* in the android/build.gradlec:

  ```
  dependencies {
  classpath"org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
  classpath"com.google.gms:google-services:4.4.0"
  }
  ```
* in android/app/build.gradle

```
plugins {  
id"com.android.application"  
id"kotlin-android"  
id"dev.flutter.flutter-gradle-plugin"  
id("com.google.gms.google-services")
}
```



```
dependencies {implementation(platform("com.google.firebase:firebase-bom:32.3.1"))}
applyplugin: 'com.google.gms.google-services'
```



- (skip if not running on iOS)

* Create an app within your Firebase instance for iOS, with your app package name
* Follow instructions to download GoogleService-Info.plist
* Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the
  GoogleService-Info.plist file to add it to /ios/Runner in XCode
* Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item
  in the array value of this key is specific to the Firebase instance. Replace it with the value for
  REVERSED_CLIENT_ID from GoogleService-Info.plist

Double check install instructions for both

- Google Auth Plugin
  - https://pub.dartlang.org/packages/firebase_auth
- Firestore Plugin
  - https://pub.dartlang.org/packages/cloud_firestore

# What's Next?

* [ ] Video Calling
* [ ] Vocal Calling
* [ ] Post multi Media with carousel
* [ ] Sending and Uploading Videos(Video Compatibility)
* [ ] Sending and Uploading Vocal and Audio (AudioCompatibility)
* [ ] Geolocalisation
* [ ] Kind of Users : Tatoo Artist, Event Organisator, Client
* [ ] Choose style page impoved and storage in firebase for Tatoo Artist
* [ ] System of secret key for the licence management (Tatoo Artist, announcers, Event Organisator)
* [ ] Modify feeds page to manage right of posting only from Tatao Artist, Event Organisator,announcer
* [ ] Tatoo Flash system with Tinder SYstem (swipe card with Super Like to contact the tatoo Artist)
* [ ] Search improvement by Artists, Styles, Geolocalisation, Avalaible Flashes
* [ ] Manage tatoo styles in Profile Page for Tatoo Artist
* [ ] Add Google Auth system
* [ ] Add Meta (Facebook, Instagram) Auth
* [ ] Get the Instagram Post to push on tatoo connect ?
* [ ] Push Tatoo Connect to Instagram Account ?
* [ ] Double Authentication by phone number ?

### Known Issues

* For Artist, there is an issu on Signup, the Tatoo Style pages appears before Photo Profile, ans the selected styles are not saved.

# Note

- The stories feature is ready, you can write a cloud scheduler function to auto delete stories
  after 24hrs as cloud functions is not enabled in this project
