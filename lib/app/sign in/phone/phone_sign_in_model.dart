import 'package:pulsera_rastreadora_124/app/sign%20in/validators.dart';

enum PhoneSignInFormType { signIn, register }

class EmailSignInModel with PhoneValidators {
  EmailSignInModel({
    this.phoneNumber = '',
    this.password = '',
    this.formType = PhoneSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String phoneNumber;
  final String password;
  final PhoneSignInFormType formType;
  final bool isLoading;
  final bool submitted;

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
    return phoneNumberValidator.isValid(phoneNumber) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText =
        submitted && !phoneNumberValidator.isValid(phoneNumber);
    return showErrorText ? invalidPhoneNumberErrorText : null;
  }

  EmailSignInModel copyWith({
    String phoneNumber,
    String password,
    PhoneSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
