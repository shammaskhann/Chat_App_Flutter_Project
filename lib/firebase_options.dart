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
    apiKey: 'AIzaSyDFnw6XfVfKO5wjULtnszqG49xPSyLWGDk',
    appId: '1:609418779676:web:93cf9e783ebb654daa13d9',
    messagingSenderId: '609418779676',
    projectId: 'chat-app-project-fa5c1',
    authDomain: 'chat-app-project-fa5c1.firebaseapp.com',
    storageBucket: 'chat-app-project-fa5c1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbnJBuQX_5QlEZofacZ0vKo3alcBxTC_w',
    appId: '1:609418779676:android:18571c6849cadee3aa13d9',
    messagingSenderId: '609418779676',
    projectId: 'chat-app-project-fa5c1',
    storageBucket: 'chat-app-project-fa5c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaxwNlpZfaEhBmwLSC3UMLmSvn3FMQMe8',
    appId: '1:609418779676:ios:e73f4bbe7dd35e94aa13d9',
    messagingSenderId: '609418779676',
    projectId: 'chat-app-project-fa5c1',
    storageBucket: 'chat-app-project-fa5c1.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseProjectApp',
  );
}