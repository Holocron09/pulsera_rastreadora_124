import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/Facebook_signin_page.dart';

class UserAuth {
  UserAuth({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  //Future<UserAuth> signInWithFacebook();
  Future<UserAuth> currentUser();
  Future<UserAuth> signInAnonymously();
  Future<void> signOut();
  Stream<UserAuth> get onAuthStateChanged;
  Future<UserAuth> signInWithGoogle();
  Future<UserAuth> signInWithEmailAndPassword(String email, String password);
  Future<UserAuth> createUserWithEmailAndPassword(
      String email, String password);
  Future<UserAuth> loginWithFacebook(BuildContext context);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  UserAuth _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserAuth(uid: user.uid);
  }

  @override
  Future<UserAuth> loginWithFacebook(BuildContext context) async {
    final signInPage = FacebookLogInPage();
    final String result = await signInPage.facebookLogInCredentials(context);
    if (result != null) {
      final facebookAuthCred = FacebookAuthProvider.credential(result);
      final authResult =
          await _firebaseAuth.signInWithCredential(facebookAuthCred);
      return _userFromFirebase(authResult.user);
    }
    throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  }

  Future<UserAuth> signInWithPhoneNumber(String phoneNumber) async {
    final authResult = await _firebaseAuth.signInWithPhoneNumber(phoneNumber);
    //return _userFromFirebase(authResult.verificationId);
  }

  @override
  Stream<UserAuth> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserAuth> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<UserAuth> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<UserAuth> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

/*
  Future<UserAuth> signInWithPhoneNumber()async{
    final authResult =await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '123',
      timeout : Duration(seconds: 60),
    );
    return null;
  }
*/
  @override
  Future<UserAuth> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  /* @override
  Future<UserAuth> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();

    final result = await facebookLogin.logInWithReadPermissions(
      ['public_profile'],
    );
    if (result.accessToken != null) {
      final authResult = await _firebaseAuth
          .signInWithCredential(FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      ));
      return _userFromFirebase(authResult.user);
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }
*/
  @override
  Future<UserAuth> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR _MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
