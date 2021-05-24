import 'package:flutter/foundation.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/phone/phone_sign_in_model.dart';
import 'package:pulsera_rastreadora_124/app/sign%20in/validators.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';

class PhoneSignInChangeModel with PhoneValidators, ChangeNotifier {
  PhoneSignInChangeModel({
    @required this.auth,
    this.phone = '',
    this.password = '',
    this.formType = PhoneSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });
  final AuthBase auth;
  String phone;
  String password;
  PhoneSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);

    try {
      if (formType == PhoneSignInFormType.signIn) {
        //await auth.signInWithphoneAndPassword(phone, password);
      } else {
        //await auth.createUserWithphoneAndPassword(phone, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    } finally {}
  }

  String get primaryButtonText {
    return formType == PhoneSignInFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
  }

  String get secondaryButtonText {
    return formType == PhoneSignInFormType.signIn
        ? 'Need an Account?... Register'
        : 'Have an account?... Sign in';
  }

  bool get canSubmit {
    return phoneNumberValidator.isValid(phone) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(phone);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get phoneErrorText {
    bool showErrorText = submitted && !phoneNumberValidator.isValid(phone);
    return showErrorText ? invalidPhoneNumberErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == PhoneSignInFormType.signIn
        ? PhoneSignInFormType.register
        : PhoneSignInFormType.signIn;
    updateWith(
      phone: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updatePhone(String phone) => updateWith(phone: phone);
  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String phone,
    String password,
    PhoneSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.phone = phone ?? this.phone;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
