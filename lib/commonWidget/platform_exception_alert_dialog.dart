import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:pulsera_rastreadora_124/commonWidget/plattform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    if (exception.message == 'FIRFirestoreErrorDomain') {
      if (exception.code == 'Error 7') {
        return 'Missing or insufficient permissions';
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'firebase_auth/wrong-password': 'The password is invalid',
    'ERROR_WEAK_PASSWORD': 'The password is not strong enough.',
    'ERROR_EMAIL_ALREADY_IN_USE': 'The email is already in use.',
    'ERROR_INVALID_EMAIL':
        ' The email address should look like: test@test.com.',
    'ERROR_WRONG_PASSWORD': 'The password is invalid',
    'ERROR_USER_NOT_FOUND': 'There is no user for the given email address.',
    'ERROR_USER_DISABLED': 'The user has been disabled please contact support',
    'ERROR_TOO_MANY_REQUESTS':
        'There have been too many attempts to sign in with this user.',
  };
}
