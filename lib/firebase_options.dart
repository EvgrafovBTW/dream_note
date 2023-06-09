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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB9ABbYVrltEM4lLLz5cFGaM-I3mmOPxJs',
    appId: '1:300773761826:android:3a9cc487e03fab7ce1fb7b',
    messagingSenderId: '300773761826',
    projectId: 'dream-note-fba4c',
    storageBucket: 'dream-note-fba4c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkn8MXZXzgDp_SJhA0cmG4dpRErZINhmY',
    appId: '1:300773761826:ios:3c5a9576824d2c2be1fb7b',
    messagingSenderId: '300773761826',
    projectId: 'dream-note-fba4c',
    storageBucket: 'dream-note-fba4c.appspot.com',
    androidClientId: '300773761826-nr0th3rdfnthtj2ovee4ppf7cn391cs7.apps.googleusercontent.com',
    iosClientId: '300773761826-rqcmk2oea7iptl3gls95qd5eoolvvs80.apps.googleusercontent.com',
    iosBundleId: 'com.example.dreamNote',
  );
}
