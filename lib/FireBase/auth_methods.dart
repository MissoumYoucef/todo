import 'package:firebase_auth/firebase_auth.dart';


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //login process


  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res='';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // register user

        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = 'ok';
      }
    } on FirebaseAuthException catch (_) {
      res ='Failed to Login';
    }catch (e) {
      res = 'Error';
    }
    return res;
  }

  //signOut process

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
