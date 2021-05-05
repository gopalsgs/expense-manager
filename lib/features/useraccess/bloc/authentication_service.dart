import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signInAnonymously() async {
    try {
      final user = await _auth.signInAnonymously();
      print(user);
      return user;
    } catch (e) {
      print('Error = $e');
      return e.message;
    }
  }
}
