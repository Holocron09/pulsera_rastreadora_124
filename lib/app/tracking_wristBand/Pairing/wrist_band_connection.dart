import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/mini_web_browser.dart';

class BandPair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Para emparejar esta pulsera mantenga presionado el botón trasero durante 5 segundos',
              textAlign: TextAlign.center,
              textScaleFactor: 1.7,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              child: TextButton(
                //color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MiniWebBrowser(
                          title: 'Configuración de\nla pulsera',
                          initialUrl: 'http://esp32.local/',
                        );
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Text(
                  'Continuar',
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
