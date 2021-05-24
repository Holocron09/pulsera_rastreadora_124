import 'package:flutter/cupertino.dart';
import 'package:pulsera_rastreadora_124/commonWidget/CustomRaisedButton.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) :assert(text!=null),
      assert(assetName!=null),

       super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assetName),
        Text(
          text,
          style: TextStyle(
            color: textColor,fontSize: 16.0,
          ),),
        Opacity(
          opacity: 0.0,
          child: Image.asset(assetName),
        ),
      ],
    ),
    color: color,
    height: 40.0,
    onPressed: onPressed,
  );
}
