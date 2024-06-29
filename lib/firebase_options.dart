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
        return macos;
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
    apiKey: 'AIzaSyCTHwy6z1-Su40ByzoMb1lwx6mwhU82CkE',
    appId: '1:1024248956501:web:130990aaf00ff870efb6dc',
    messagingSenderId: '1024248956501',
    projectId: 'test-firebase-916f2',
    authDomain: 'test-firebase-916f2.firebaseapp.com',
    storageBucket: 'test-firebase-916f2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsmKnmvpMCNSLl8XJoXBQmuFVNXk5iGv0',
    appId: '1:1024248956501:android:bfd6759e0659e531efb6dc',
    messagingSenderId: '1024248956501',
    projectId: 'test-firebase-916f2',
    storageBucket: 'test-firebase-916f2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAyPngtTVRgN30WL2N0FilPvSZ3250a6I',
    appId: '1:1024248956501:ios:ee8a5e155f3960caefb6dc',
    messagingSenderId: '1024248956501',
    projectId: 'test-firebase-916f2',
    storageBucket: 'test-firebase-916f2.appspot.com',
    iosClientId: '1024248956501-ss38hv8t7cq1i0g6pl0ikkpmt7eqfc56.apps.googleusercontent.com',
    iosBundleId: 'com.mikkyboy.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAyPngtTVRgN30WL2N0FilPvSZ3250a6I',
    appId: '1:1024248956501:ios:7e7887f982413d40efb6dc',
    messagingSenderId: '1024248956501',
    projectId: 'test-firebase-916f2',
    storageBucket: 'test-firebase-916f2.appspot.com',
    iosClientId: '1024248956501-0nvvg2ie2jr914mkvmvob87489p0lc0s.apps.googleusercontent.com',
    iosBundleId: 'com.jonathan.tatooconnect.RunnerTests',
  );
}
