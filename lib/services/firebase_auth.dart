import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    Future<UserCredential> loginUsingEmailPasswor({required String email, required String pasword}) async {
        try {
            UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pasword);
            return userCredential;
        } catch (e) {
          rethrow;
        }
    }
}