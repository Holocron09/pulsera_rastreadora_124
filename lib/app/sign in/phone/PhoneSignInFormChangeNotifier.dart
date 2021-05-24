import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/phone/phone_sign_in_change_model.dart';
import 'package:pulsera_rastreadora_124/commonWidget/Form_submit_button.dart';
import 'package:pulsera_rastreadora_124/commonWidget/platform_exception_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class PhoneSignInFormChangeNotifier extends StatefulWidget {
  PhoneSignInFormChangeNotifier({@required this.model});
  final PhoneSignInChangeModel model;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<PhoneSignInChangeModel>(
      create: (context) => PhoneSignInChangeModel(auth: auth),
      child: Consumer<PhoneSignInChangeModel>(
        builder: (context, model, _) => PhoneSignInFormChangeNotifier(
          model: model,
        ),
      ),
    );
  }

  @override
  _PhoneSignInFormChangeNotifierState createState() =>
      _PhoneSignInFormChangeNotifierState();
}

class _PhoneSignInFormChangeNotifierState
    extends State<PhoneSignInFormChangeNotifier> {
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  PhoneSignInChangeModel get model => widget.model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  List<Widget> _buildChildren() {
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
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(
        height: 20,
      ),
      TextButton(
        child: Text(model.secondaryButtonText),
        onPressed: model.isLoading ? () => null : _toggleFormType,
      )
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _phoneController,
      focusNode: _phoneFocusNode,
      decoration: InputDecoration(
        labelText: 'Please enter your phone number:',
        hintText: '(111)111111',
        errorText: model.phoneErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onChanged: model.updatePhone,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextField _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: model.updatePassword,
    );
  }

  void _emailEditingComplete() {
    final newFocus = model.phoneNumberValidator.isValid(model.phone)
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
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign In Failed\n',
        exception: e,
      ).show(context);
    }
  }

  void _toggleFormType() {
    model.toggleFormType();
    _phoneController.clear();
    _passwordController.clear();
  }
}
