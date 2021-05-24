import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/commonWidget/plattform_alert_dialog.dart';

class LocationOptions extends StatefulWidget {
  @override
  _LocationOptionsState createState() => _LocationOptionsState();
}

class _LocationOptionsState extends State<LocationOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRequestButtons(
              buttonTitle: 'Request Location',
              onPressed: () => PlatformAlertDialog(
                title: 'your patient is located here : ',
                content: '[patient coordinates] ',
                defaultActionText: 'OK',
              ),
            ),
            CustomRequestButtons(
              buttonTitle: 'Press for Location History',
              //'Latest 3 locations: \nLocation 1: {current location} \nLocation 2: {last location} \nLocation 3 {ulatest location}',
              onPressed: () => PlatformAlertDialog(
                title: 'Latest 3 locations:',
                content:
                    'Location 1: {current location} \nLocation 2: {last location} \nLocation 3 {u latest location}',
                defaultActionText: 'OK',
              ),
            ),
            CustomRequestButtons(
              buttonTitle: 'Open in Google Maps',
              onPressed: () {},
            ),
            CustomRequestButtons(
              buttonTitle: 'Share App with Friends',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRequestButtons extends StatelessWidget {
  CustomRequestButtons({
    @required this.buttonTitle,
    this.onPressed,
  });
  final String buttonTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0)))),
                onPressed: onPressed,
                child: Text(buttonTitle),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
