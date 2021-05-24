import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/providers/Serial_transfer_provider.dart';

// Crea un Widget Form
class WiFiCredentialsForm extends StatefulWidget {
  const WiFiCredentialsForm({@required this.wifiSocketSender});
  final WiFiSocketSender wifiSocketSender;

  @override
  WiFiCredentialsFormState createState() {
    return WiFiCredentialsFormState();
  }
}

class WiFiCredentialsFormState extends State<WiFiCredentialsForm> {
  final _formKeySSID = GlobalKey<FormState>();
  final _formKeyPSWD = GlobalKey<FormState>();
  final _wifiSSIDController = TextEditingController();
  final _wifiPSWDController = TextEditingController();

  // ignore: non_constant_identifier_names
  final _SSIDFocusNode = FocusNode();

  // ignore: non_constant_identifier_names
  final _PSWDFocusNode = FocusNode();

  void dispose() {
    _wifiSSIDController.dispose();
    _wifiPSWDController.dispose();
    _SSIDFocusNode.dispose();
    _PSWDFocusNode.dispose();
    super.dispose();
  }

  bool validator(String value) {
    return value.isNotEmpty ? true : false;
  }

  bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = false;
    super.initState();
  }

  void _enableButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              autofocus: true,
              focusNode: _SSIDFocusNode,
              controller: _wifiSSIDController,
              key: _formKeySSID,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => _PSWDFocusNode.requestFocus(),
              decoration: const InputDecoration(
                icon: Icon(Icons.wifi),
                hintText: 'Ingrese un SSID valido',
                labelText: 'SSID',
              ),
              validator: (String value) {
                return value.isEmpty
                    ? 'Por favor ingrese un SSID valido'
                    : null;
              },
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              focusNode: _PSWDFocusNode,
              controller: _wifiPSWDController,
              key: _formKeyPSWD,
              //onEditingComplete: () => _submit(widget.wifiSocketSender),
              decoration: const InputDecoration(
                icon: Icon(Icons.lock),
                hintText: 'Ingrese una contraseña valida',
                labelText: 'Password',
              ),
              validator: (String value) {
                return value.isEmpty
                    ? 'Por favor ingrese una contraseña valida'
                    : null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (validator(_wifiSSIDController.text) &&
                      validator(_wifiPSWDController.text)) {
                    print(_wifiSSIDController.text);
                    widget.wifiSocketSender.sSID = _wifiSSIDController.text;
                    widget.wifiSocketSender.pSWD = _wifiPSWDController.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    _enableButton();
                    print('enviado');
                  }
                },
                child: Text('Submit'),
              ),
            ),
            SizedBox(
              child: TextButton(
                //color: Colors.white,
                onPressed: _isButtonDisabled
                    ? () => Navigator.of(context).pop()
                    : null,
                child: Text(
                  'Continuar',
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(WiFiSocketSender configuration) {
    if (validator(_wifiSSIDController.text) &&
        validator(_wifiPSWDController.text)) {
      print(_wifiSSIDController.text);
      configuration.sSID = _wifiSSIDController.text;
      configuration.pSWD = _wifiPSWDController.text;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      _enableButton();
      print('enviado');
    }
  }
}
