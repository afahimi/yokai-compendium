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
    apiKey: 'AIzaSyDTgmJ5JRqoX4GW0Qz5d3MnijESz8H0oPo',
    appId: '1:341366501414:web:fc179b914be0f5e53cf6e7',
    messagingSenderId: '341366501414',
    projectId: 'yo-kai-compendium',
    authDomain: 'yo-kai-compendium.firebaseapp.com',
    storageBucket: 'yo-kai-compendium.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAW0b7u-cAUgoo9j0woc_pZkTA0JUYjJmc',
    appId: '1:341366501414:android:a92574478945e1cf3cf6e7',
    messagingSenderId: '341366501414',
    projectId: 'yo-kai-compendium',
    storageBucket: 'yo-kai-compendium.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_fJ7tCe98AapTX2V81vfplx6JTNf28qg',
    appId: '1:341366501414:ios:fa7affd89303c30a3cf6e7',
    messagingSenderId: '341366501414',
    projectId: 'yo-kai-compendium',
    storageBucket: 'yo-kai-compendium.appspot.com',
    iosBundleId: 'com.aminfahimi.iosapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_fJ7tCe98AapTX2V81vfplx6JTNf28qg',
    appId: '1:341366501414:ios:b527ad0c55d6aa2c3cf6e7',
    messagingSenderId: '341366501414',
    projectId: 'yo-kai-compendium',
    storageBucket: 'yo-kai-compendium.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
