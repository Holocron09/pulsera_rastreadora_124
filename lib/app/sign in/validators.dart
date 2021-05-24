abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class PhoneValidators {
  final StringValidator phoneNumberValidator = NonEmptyStringValidator();
  final String invalidPhoneNumberErrorText = 'Phone number can\'t be empty';
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}
