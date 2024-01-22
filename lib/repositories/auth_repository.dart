import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> userSignUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> userSignIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<User?> googleSignIn() async {
    try {
      await GoogleSignIn().signIn().then((googleAccount) async {
        if (googleAccount != null) {
          final auth = await googleAccount.authentication;
          final credential = GoogleAuthProvider.credential(
            idToken: auth.idToken,
            accessToken: auth.accessToken,
          );
          await _firebaseAuth.signInWithCredential(credential);
        }
      });
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> userSignOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
