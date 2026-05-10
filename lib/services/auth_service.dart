import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInAnonymously() async {
    if (_auth.currentUser != null) {
      return _auth.currentUser;
    }

    final UserCredential userCredential = await _auth.signInAnonymously();
    return userCredential.user;
  }

  User? get currentUser => _auth.currentUser;
}
