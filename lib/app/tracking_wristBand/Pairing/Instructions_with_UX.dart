import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/providers/Serial_transfer_provider.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/Pairing/ProfileForm.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/Pairing/formulario_wifi.dart';

class TextScreen {
  Widget _textScreen(String _text, VoidCallback onPressed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            _text,
            textAlign: TextAlign.center,
            textScaleFactor: 1.7,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          child: TextButton(
            style: TextButton.styleFrom(primary:Colors.white),
            onPressed: onPressed,
            child: Text(
              'Continuar',
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }
}

class BandPairing extends StatefulWidget {
  final WiFiSocketSender _wiFiSocketSender = WiFiSocketSender();

  @override
  _BandPairingState createState() => _BandPairingState();

  void connectSocket() async {
    final Socket _socket =
        await Socket.connect('192.168.31.99', 80).then((result) {
      print(result);
      _wiFiSocketSender.channel = result;
      return result;
    });

    print('connected');
  }
}

String _text1;
int _counter = 0;
final List instructionsList = [
  'Este Asistente le guiará para configurar su pulsera',
  'Para emparejar la pulsera mantenga presionado el botón trasero durante 5 segundos',
  'Abra a Ajustes -> Wi-Fi -> Seleccione la red ->”ESP-8266"',
  'Ahora vamos a introducir credenciales de Wi-Fi\nLa pulsera intentará conectarse a las redes  Wi-Fi conocidas antes de utilizar datos celulares',
  'La pulsera se reiniciará y se conectará a la red Wi-Fi configurada anteriormente.',
  'Es necesario configurar el perfil de quien va a utilizar esta pulsera\n Esta información se utiliza únicamente para referencia',
  'La pulsera se reiniciará y se conectará a la red Wi-Fi configurada anteriormente.',
];

class _BandPairingState extends State<BandPairing> {
  static const menuItems=<String>[
    'Telcel','Movistar','AT&T','Virgin-Mobile'
  ];

  final List <DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
          (String value)=>DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),)
          .toList();

      @override
  void initState() {
    _text1 = instructionsList[0];
    super.initState();
  }

  void updateState() {
    setState(() {
      _text1 = instructionsList[_counter];
      _counter > instructionsList.length ? _counter = 0 : _counter++;
    });
  }


      @override
  Widget build(BuildContext context) {



        String _btn3SelectedVal;
    final TextScreen textWidget = TextScreen();

    switch (_counter) {
      case 1:
        {
          return textWidget._textScreen(
            _text1,
            () {
              widget.connectSocket();
              updateState();
            },
          );
        }
        break;
      case 0:
      case 2:
        {
          return textWidget._textScreen(
            _text1,
            () {
              updateState();
            },
          );
        }
        break;
      case 3:
        {
          return textWidget._textScreen(_text1, () {
            updateState();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WiFiCredentialsForm(
                wifiSocketSender: widget._wiFiSocketSender,
              ),
            ));
          });
        }
        break;
      case 4:
        {
          return textWidget._textScreen(
            _text1,
            () {
              updateState();
            },
          );
        }
        break;
      case 5:
        {
          return textWidget._textScreen(_text1, () {
            updateState();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => UserProfileForm(
                channel: widget._wiFiSocketSender,
              ),
            ));
          });
        }
        break;
      case 6:
        {
          return ListTile(
            title: const Text('Seleccione la compañia de la tarjeta SIM de la pulsera'),
            trailing: DropdownButton(
                value: _btn3SelectedVal,
                  hint: Text('Seleccione'),
                  onChanged: ((String newValue) {
                    setState(() {
                      _btn3SelectedVal=newValue;
                    });
                  }),


                items: _dropDownMenuItems,),);

        }
        break;

      default:
        return Container();
    }
  }
}

