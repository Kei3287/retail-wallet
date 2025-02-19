import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDHGNfGfIcUpfg8b4yX7eF_caAH0KhMRm0",
            authDomain: "rlusd-wallet.firebaseapp.com",
            projectId: "rlusd-wallet",
            storageBucket: "rlusd-wallet.firebasestorage.app",
            messagingSenderId: "1070094433616",
            appId: "1:1070094433616:web:05e7e73f2ce353270c0055",
            measurementId: "G-4TLM54V6KE"));
  } else {
    await Firebase.initializeApp();
  }
}
