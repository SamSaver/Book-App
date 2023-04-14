// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'package:firebase_core/firebase_core.dart';

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
    apiKey: 'AIzaSyCUgc9uMQi_QmOrL7lNTwxudOXWlgqfvwY',
    appId: '1:830628572486:web:df37433229f52cbbfec947',
    messagingSenderId: '830628572486',
    projectId: 'quiz-app-6ed1f',
    authDomain: 'quiz-app-6ed1f.firebaseapp.com',
    storageBucket: 'quiz-app-6ed1f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1j4pMSv2Sh1iKser_nvTT8HTfxUh0vHA',
    appId: '1:830628572486:android:44e70192b1f99f58fec947',
    messagingSenderId: '830628572486',
    projectId: 'quiz-app-6ed1f',
    storageBucket: 'quiz-app-6ed1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClBEz5AkgQY-6UvUKNp5QR7T3aSFwTTac',
    appId: '1:830628572486:ios:7aa5c045ba179384fec947',
    messagingSenderId: '830628572486',
    projectId: 'quiz-app-6ed1f',
    storageBucket: 'quiz-app-6ed1f.appspot.com',
    iosClientId:
        '830628572486-g4gugoch88pl28hohle8tvdk2ujf8ok3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterWorld',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClBEz5AkgQY-6UvUKNp5QR7T3aSFwTTac',
    appId: '1:830628572486:ios:7aa5c045ba179384fec947',
    messagingSenderId: '830628572486',
    projectId: 'quiz-app-6ed1f',
    storageBucket: 'quiz-app-6ed1f.appspot.com',
    iosClientId:
        '830628572486-g4gugoch88pl28hohle8tvdk2ujf8ok3.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterWorld',
  );
}
