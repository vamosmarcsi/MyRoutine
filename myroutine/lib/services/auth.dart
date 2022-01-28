import 'package:firebase_auth/firebase_auth.dart';
import 'package:myroutine/models/myuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create object based on FirebaseUser
  MyUser? _userFromFirebaseUser(User user) {
    //return user != null ? MyUser(uid: user.uid) : null;
    return MyUser(uid: user.uid);
  }

  //
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  //sign-in anonymously
  Future signInAnonym() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User? user = res.user;
      return _userFromFirebaseUser(user!);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //sign-in with email and pw
  Future signInWithEmailAndPw(String email, String pw) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: pw);
      User? user = res.user;
      return _userFromFirebaseUser(user!);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //register with email and pw
  Future regWithEmailAndPw(String email, String pw) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: email, password: pw);
      User? user = res.user;
      return _userFromFirebaseUser(user!);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
