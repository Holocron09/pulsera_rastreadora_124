import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/commonWidget/CustomRaisedButton.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          borderRadius: 20,
          onPressed: onPressed,
        );
}
