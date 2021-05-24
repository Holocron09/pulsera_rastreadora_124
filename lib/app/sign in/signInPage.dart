import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/email/email_sign_in.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/phone/phone_sign_in_page.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/signInButton.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/sign_in_manager.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/socialSignInButton.dart';
import 'package:pulsera_rastreadora_124/commonWidget/platform_exception_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  final bool isLoading;
  final SignInManager manager;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign In Failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithPhoneNumber(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => PhoneSignInPage(),
    ));
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }
/*
  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      manager.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }*/

  Future<void> _loginWithFacebook(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      auth.loginWithFacebook(context);
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pulsera Rastreadora'),
        elevation: 2,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(
            height: 50,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign In with Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 10,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign In with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: isLoading ? null : () => _loginWithFacebook(context),
            //onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 10,
          ),
          /*SignInButton(
            text: 'Sign In with Email',
            textColor: Colors.white,
            color: Colors.green,
            onPressed: isLoading ? null :  ()=> _signInWithEmail(context),

          ),*/
          SocialSignInButton(
            assetName: 'images/email-icon2.png',
            text: 'Sign In with E-mail',
            textColor: Colors.white,
            color: Colors.green,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 10,
          ),
          SocialSignInButton(
            assetName: 'images/Telephone-icon.png',
            text: 'Sign In with Phone number',
            textColor: Colors.black,
            color: Colors.yellow,
            onPressed: isLoading ? null : () => _signInWithPhoneNumber(context),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'or\n',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SignInButton(
            text: 'Go anonymus',
            textColor: Colors.white,
            color: Colors.black12,
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

/*
  Future<Widget> _webVisualize(BuildContext context) async {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (_) {
        return MiniWebBrowser(
            title: 'Configuración de\nla pulsera',
            initialUrl: 'http://192.168.31.99/');
      }),
    );
  }
*/
  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
