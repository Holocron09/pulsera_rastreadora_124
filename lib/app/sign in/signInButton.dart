import 'package:flutter/cupertino.dart';
import 'package:pulsera_rastreadora_124/commonWidget/CustomRaisedButton.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
          color: color,
          height: 40.0,
          onPressed: onPressed,
        );
}
