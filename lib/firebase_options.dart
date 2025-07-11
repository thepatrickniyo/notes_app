import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      // case TargetPlatform.macOS:
      //   return macos;
      // case TargetPlatform.windows:
      //   return windows;
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

  // NEW FIREBASE PROJECT CONFIGURATION
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBpyPKwjseOUPNPXn4r-Sr8vKuxYSO2T9c',
    appId: '1:225902784420:web:81bf78d6d73d09ba7e9b31',
    messagingSenderId: '225902784420',
    projectId: 'notes-app-a9c98',
    authDomain: 'notes-app-a9c98.firebaseapp.com',
    // storageBucket: 'notes-app-a9c98.firebasestorage.app',
    measurementId: 'G-83BSY697EX',
  );

  // Note: You'll need to generate these configurations for other platforms
  // using the FlutterFire CLI or Firebase Console
  static const FirebaseOptions android = FirebaseOptions(
    apiKey:
        'AIzaSyBpyPKwjseOUPNPXn4r-Sr8vKuxYSO2T9c', // Update with Android-specific key
    appId:
        '1:225902784420:android:bafaafd3939e8bb77e9b31', // Update with actual Android app ID from Firebase Console
    messagingSenderId: '225902784420',
    projectId: 'notes-app-a9c98',
    // storageBucket: 'notes-app-a9c98.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey:
        'AIzaSyBpyPKwjseOUPNPXn4r-Sr8vKuxYSO2T9c', // Update with iOS-specific key
    appId:
        '1:225902784420:ios:3d15ed800f1cd20a7e9b31', // Update with actual iOS app ID
    messagingSenderId: '225902784420',
    projectId: 'notes-app-a9c98',
    // storageBucket: 'notes-app-a9c98.firebasestorage.app',
    iosBundleId: 'com.example.notesTakingApp',
  );
}
