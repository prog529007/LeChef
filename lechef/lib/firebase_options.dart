// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAlhs2LHaJUTDuPrkGLxnkehX7A6XH2_V0',
    appId: '1:251943637245:web:1afc28ddce04a39b306e94',
    messagingSenderId: '251943637245',
    projectId: 'chefitup-19f27',
    authDomain: 'chefitup-19f27.firebaseapp.com',
    storageBucket: 'chefitup-19f27.appspot.com',
    measurementId: 'G-QS0PS3T0YZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEzEetMDZ6SI2u2YjGE-EG7k27sLMtZIQ',
    appId: '1:251943637245:android:8752919977903692306e94',
    messagingSenderId: '251943637245',
    projectId: 'chefitup-19f27',
    storageBucket: 'chefitup-19f27.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLpbBAMwBZP6ioAi3pcJsPWpRNBnem5oQ',
    appId: '1:251943637245:ios:84623ef40431171c306e94',
    messagingSenderId: '251943637245',
    projectId: 'chefitup-19f27',
    storageBucket: 'chefitup-19f27.appspot.com',
    iosBundleId: 'com.example.lechef',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLpbBAMwBZP6ioAi3pcJsPWpRNBnem5oQ',
    appId: '1:251943637245:ios:84623ef40431171c306e94',
    messagingSenderId: '251943637245',
    projectId: 'chefitup-19f27',
    storageBucket: 'chefitup-19f27.appspot.com',
    iosBundleId: 'com.example.lechef',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAlhs2LHaJUTDuPrkGLxnkehX7A6XH2_V0',
    appId: '1:251943637245:web:e8ad52750f1bb231306e94',
    messagingSenderId: '251943637245',
    projectId: 'chefitup-19f27',
    authDomain: 'chefitup-19f27.firebaseapp.com',
    storageBucket: 'chefitup-19f27.appspot.com',
    measurementId: 'G-TEWJHNMVJ9',
  );
}
