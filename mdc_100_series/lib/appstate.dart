import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shrine/src/authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {

    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        _loginState = ApplicationLoginState.loggedOut;
        print(': User is currently signed out!');
      } else {
        _loginState = ApplicationLoginState.loggedIn;
        print(user.uid + ': User is signed in!');
      }
      notifyListeners();
    });

  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.loggedIn;
    notifyListeners();
  }

  Future<void> signInAnonymously(
      void Function(FirebaseAuthException e) errorCallback
      ) async {
    try{
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signWithGoogle(
      void Function(FirebaseAuthException e) errorCallback
      ) async {
    try{
      await signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

}