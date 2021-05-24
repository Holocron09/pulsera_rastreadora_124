import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/email/email_sign_in_model.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/validators.dart';
import 'package:pulsera_rastreadora_124/commonWidget/Form_submit_button.dart';
import 'package:pulsera_rastreadora_124/commonWidget/platform_exception_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class PhoneSignInFormStateful extends StatefulWidget with PhoneValidators {
  @override
  _PhoneSignInFormStatefulState createState() =>
      _PhoneSignInFormStatefulState();
}

class _PhoneSignInFormStatefulState extends State<PhoneSignInFormStateful> {
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _phoneController.text;
  String get _password => _passwordController.text;
  bool _submitted = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account?... Register'
        : 'Have an account?... Sign in';

    bool submitEnabled = widget.phoneNumberValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 10,
      ),
      _buildPasswordField(),
      SizedBox(
        height: 10,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 20,
      ),
      TextButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      )
    ];
  }

  TextField _buildEmailTextField() {
    bool showErrorText =
        _submitted && !widget.phoneNumberValidator.isValid(_email);
    return TextField(
      controller: _phoneController,
      focusNode: _phoneFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidPhoneNumberErrorText : null,
        enabled: _isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  TextField _buildPasswordField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_email);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
    );
  }

  void _emailEditingComplete() {
    final newFocus = widget.phoneNumberValidator.isValid(_email)
        ? _passwordFocusNode
        : _phoneFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign In Failed\n',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _phoneController.clear();
    _passwordController.clear();
  }

  void _updateState() {
    setState(() {});
  }
}
