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
    apiKey: 'AIzaSyDsJUlL2TnbzXaLZ2FRvJXcDJl4bnjeUyU',
    appId: '1:371640542440:web:cc1814cffa57f34aa8155d',
    messagingSenderId: '371640542440',
    projectId: 'meatzy-9f511',
    authDomain: 'meatzy-9f511.firebaseapp.com',
    storageBucket: 'meatzy-9f511.appspot.com',
    measurementId: 'G-98CB239Q0C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoMKZ4Ay3PNKliiKlAEo5sRzOVjpGBY7M',
    appId: '1:371640542440:android:aa18d0d19e3a6bf0a8155d',
    messagingSenderId: '371640542440',
    projectId: 'meatzy-9f511',
    storageBucket: 'meatzy-9f511.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHbiR52Myj5vS3G2Uxn5rxnKXqrQvmpQ0',
    appId: '1:371640542440:ios:61d6159442da98fea8155d',
    messagingSenderId: '371640542440',
    projectId: 'meatzy-9f511',
    storageBucket: 'meatzy-9f511.appspot.com',
    androidClientId: '371640542440-t77479ebaogo1a75p2p9j3v22i13tda4.apps.googleusercontent.com',
    iosClientId: '371640542440-g075sto0st5u5lcbm80ck03mr0g0u5nb.apps.googleusercontent.com',
    iosBundleId: 'com.example.meatzyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHbiR52Myj5vS3G2Uxn5rxnKXqrQvmpQ0',
    appId: '1:371640542440:ios:61d6159442da98fea8155d',
    messagingSenderId: '371640542440',
    projectId: 'meatzy-9f511',
    storageBucket: 'meatzy-9f511.appspot.com',
    androidClientId: '371640542440-t77479ebaogo1a75p2p9j3v22i13tda4.apps.googleusercontent.com',
    iosClientId: '371640542440-g075sto0st5u5lcbm80ck03mr0g0u5nb.apps.googleusercontent.com',
    iosBundleId: 'com.example.meatzyApp',
  );
}