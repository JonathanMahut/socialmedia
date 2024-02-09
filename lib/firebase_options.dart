// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA6FoS7kZgyOBE1opEgjJO9mJbq-C3qdpc',
    appId: '1:971080238211:web:e5ad4899f848ecd1c2c7b6',
    messagingSenderId: '971080238211',
    projectId: 'flutter-fire-instagram-c-1b81d',
    authDomain: 'flutter-fire-instagram-c-1b81d.firebaseapp.com',
    storageBucket: 'flutter-fire-instagram-c-1b81d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvdG4uBv7jPqp8q4NIUr_YlU-zeqx8ywk',
    appId: '1:971080238211:android:5ef32bf64b731ae6c2c7b6',
    messagingSenderId: '971080238211',
    projectId: 'flutter-fire-instagram-c-1b81d',
    storageBucket: 'flutter-fire-instagram-c-1b81d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACrAInjRcWBq7vVWjCdFKd19UQooG14fg',
    appId: '1:971080238211:ios:d17b344f45042d21c2c7b6',
    messagingSenderId: '971080238211',
    projectId: 'flutter-fire-instagram-c-1b81d',
    storageBucket: 'flutter-fire-instagram-c-1b81d.appspot.com',
    iosClientId: '971080238211-31t1bb6uv7dlbvrn7ke6ipsq4il82ffd.apps.googleusercontent.com',
    iosBundleId: 'com.mikkyboy.app',
  );
}