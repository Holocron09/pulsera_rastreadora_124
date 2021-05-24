import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/mini_web_browser.dart';

abstract class BandConfiguration {
  Future<Widget> showWebSession(BuildContext context);
  Widget displayWebSession();
}

class BandConfigurationScreen implements BandConfiguration {
  Future<Widget> showWebSession(BuildContext context) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => displayWebSession(),
      ),
    );
  }

  @override
  Widget displayWebSession() {
    return MiniWebBrowser(
        title: 'Configuración de\nla pulsera',
        initialUrl: 'http://esp32.local/');
  }
}
