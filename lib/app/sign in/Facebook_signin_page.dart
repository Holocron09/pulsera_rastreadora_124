import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/Custom_web_view.dart';

abstract class FacebookSignInPage {
  Future<String> facebookLogInCredentials(BuildContext context);
}

class FacebookLogInPage implements FacebookSignInPage {
  final String yourClientId = '812826056143197';
  final String yourRedirectUrl =
      'https://www.facebook.com/connect/login_success.html';

  @override
  Future<String> facebookLogInCredentials(BuildContext context) async {
    final String url =
        'https://www.facebook.com/dialog/oauth?client_id=$yourClientId&redirect_uri=$yourRedirectUrl&response_type=token&scope=email,public_profile,';
    final String result = await Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => CustomWebView(
                selectedUrl: url,
              ),
          maintainState: true),
    );
    return result;
  }
}
