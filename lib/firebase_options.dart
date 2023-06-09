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
    apiKey: 'AIzaSyAezucVLWXKme2t49069hIGEUECRrtn700',
    appId: '1:551549461549:web:f13ccacea9bbec99b8c4a4',
    messagingSenderId: '551549461549',
    projectId: 'ecom-fb10b',
    authDomain: 'ecom-fb10b.firebaseapp.com',
    storageBucket: 'ecom-fb10b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_ahRTjo0rF0KX6bcRYalqlzt6AvdN594',
    appId: '1:551549461549:android:321cb5b1de65a9d4b8c4a4',
    messagingSenderId: '551549461549',
    projectId: 'ecom-fb10b',
    storageBucket: 'ecom-fb10b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqYZB3ENpApdHDshMHUyyBuebvWHucvbQ',
    appId: '1:551549461549:ios:f3ac8839b2a6553cb8c4a4',
    messagingSenderId: '551549461549',
    projectId: 'ecom-fb10b',
    storageBucket: 'ecom-fb10b.appspot.com',
    iosClientId: '551549461549-gok7r6ma410fkcjp043mptionkrbk9uj.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqYZB3ENpApdHDshMHUyyBuebvWHucvbQ',
    appId: '1:551549461549:ios:f3ac8839b2a6553cb8c4a4',
    messagingSenderId: '551549461549',
    projectId: 'ecom-fb10b',
    storageBucket: 'ecom-fb10b.appspot.com',
    iosClientId: '551549461549-gok7r6ma410fkcjp043mptionkrbk9uj.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecom',
  );
}
