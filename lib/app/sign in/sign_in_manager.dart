import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class SignInManager {
  SignInManager({@required this.isLoading, @required this.auth});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;



  Future<UserAuth> _signIn(Future<UserAuth> Function() signInMethod) async {
    try {
      isLoading.value=true;
      return await signInMethod();
    } catch (e) {
      isLoading.value= false;
      rethrow;
    }
  }
  /*
  Future<UserAuth> loginWithFacebook(String result) async =>
      await _signIn(auth.loginWithFacebook);
*/

  /*Future<UserAuth> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
*/
  Future<UserAuth> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<UserAuth> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);
}