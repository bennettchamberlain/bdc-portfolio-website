//Write a provider using riverpods to authenticate user via FirebaseAuth



import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authProvider = Provider<AuthProvider>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthProvider(firebaseAuth);
});

class AuthProvider {
  final FirebaseAuth _firebaseAuth;

  AuthProvider(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Sign up error: $e');
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print('Sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }
}
