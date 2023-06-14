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
    apiKey: 'AIzaSyC06k9yCOlLUD9qjrMLBYQLnZs6-uEWqQE',
    appId: '1:214953573269:web:e0c6af5bcf5459474cd49c',
    messagingSenderId: '214953573269',
    projectId: 'todo-with-get-x',
    authDomain: 'todo-with-get-x.firebaseapp.com',
    storageBucket: 'todo-with-get-x.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtGy5am7eecbQhvy5A2uGr8gaZR1OTffw',
    appId: '1:214953573269:android:e4c2bbe0706dae934cd49c',
    messagingSenderId: '214953573269',
    projectId: 'todo-with-get-x',
    storageBucket: 'todo-with-get-x.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBccPJ3BjFWdwSEK25pbQ-405_52WaL07k',
    appId: '1:214953573269:ios:3d8bea3907fa21374cd49c',
    messagingSenderId: '214953573269',
    projectId: 'todo-with-get-x',
    storageBucket: 'todo-with-get-x.appspot.com',
    iosClientId: '214953573269-3khe74vlss95t8o16ocdqipu5c8j9blg.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoAppWithGetx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBccPJ3BjFWdwSEK25pbQ-405_52WaL07k',
    appId: '1:214953573269:ios:08156ee9037bd9a04cd49c',
    messagingSenderId: '214953573269',
    projectId: 'todo-with-get-x',
    storageBucket: 'todo-with-get-x.appspot.com',
    iosClientId: '214953573269-a2cfm2t9dqsq024m9fc0rs3vhqghscri.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoAppWithGetx.RunnerTests',
  );
}
