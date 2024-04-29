import 'package:chatapp/data/firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FirebaseAuthServices().updatStateOnline();
    } else if (state == AppLifecycleState.paused) {
      FirebaseAuthServices().updatStateOffline();
    }
  }
}
