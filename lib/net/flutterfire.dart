import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('Entered password is too weak!');
    } else if (e.code == 'email-already-in-use') {
      print('This email is already in use. Please login!');
    } else if (e.code == 'invalid-email') {
      print('This email is invalid!');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
