import 'package:firebase_auth/firebase_auth.dart';

class SplashServices {
  final auth = FirebaseAuth.instance;
  Future<bool> checkUser() async {
    final user = auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
