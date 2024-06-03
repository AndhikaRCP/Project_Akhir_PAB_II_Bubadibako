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
    apiKey: 'AIzaSyBr2Igs-f8eph3vjnruYB5dxu7BoFY9ZT4',
    appId: '1:72983982972:web:667ef282ecb5ff5ac3aaf9',
    messagingSenderId: '72983982972',
    projectId: 'bubadibako-project-pab-2',
    authDomain: 'bubadibako-project-pab-2.firebaseapp.com',
    storageBucket: 'bubadibako-project-pab-2.appspot.com',
    measurementId: 'G-791HFBB25P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjDVmJfnDbwb7WHp1YgQBd_b9GBH6-A6Y',
    appId: '1:72983982972:android:9de5b2dfacbf33b5c3aaf9',
    messagingSenderId: '72983982972',
    projectId: 'bubadibako-project-pab-2',
    storageBucket: 'bubadibako-project-pab-2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtkdptaCNsZrujY-korrEnBm30itgMx8I',
    appId: '1:72983982972:ios:6487361f615c7088c3aaf9',
    messagingSenderId: '72983982972',
    projectId: 'bubadibako-project-pab-2',
    storageBucket: 'bubadibako-project-pab-2.appspot.com',
    iosBundleId: 'com.example.projectAkhirPabIiBubadibako',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtkdptaCNsZrujY-korrEnBm30itgMx8I',
    appId: '1:72983982972:ios:6487361f615c7088c3aaf9',
    messagingSenderId: '72983982972',
    projectId: 'bubadibako-project-pab-2',
    storageBucket: 'bubadibako-project-pab-2.appspot.com',
    iosBundleId: 'com.example.projectAkhirPabIiBubadibako',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBr2Igs-f8eph3vjnruYB5dxu7BoFY9ZT4',
    appId: '1:72983982972:web:1eb5881c13eaccaac3aaf9',
    messagingSenderId: '72983982972',
    projectId: 'bubadibako-project-pab-2',
    authDomain: 'bubadibako-project-pab-2.firebaseapp.com',
    storageBucket: 'bubadibako-project-pab-2.appspot.com',
    measurementId: 'G-088KXDGVL0',
  );
}