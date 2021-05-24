import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/app/providers/Serial_transfer_provider.dart';

// Crea un Widget Form
class UserProfileForm extends StatefulWidget {
  const UserProfileForm({@required this.channel});

  final WiFiSocketSender channel;
  @override
  UserProfileFormState createState() {
    return UserProfileFormState();
  }
}

class UserProfileFormState extends State<UserProfileForm> {
  String lista = 'Empecemos por el nombre de quien utilizara esta pulsera';
  String lost =
      'Ahora el numero de teléfono  para notificar en caso de emergencias';
  String terra =
      'La pulsera requiere de una tarjeta SIM para enviar la ubicación cuando no esté disponible una red Wi-Fi';
  final _formKeyUserName = GlobalKey<FormState>();
  final _formKeyEmergencyPhone = GlobalKey<FormState>();
  final _formKeyWBPhone = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final _wbPhoneController = TextEditingController();
  final _currentUserFocusNode = FocusNode();
  final _emergencyPhoneFocusNode = FocusNode();
  final _wbFocusNode = FocusNode();

  void dispose() {
    _userNameController.dispose();
    _emergencyPhoneController.dispose();
    _wbPhoneController.dispose();
    _currentUserFocusNode.dispose();
    _emergencyPhoneFocusNode.dispose();
    _wbFocusNode.dispose();
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
            _userFormField(),
            _ePhoneFormField(),
            _wbPhoneFormField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _submit(widget.channel);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  _enableButton();
                  print('enviado');
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
    if (validator(_userNameController.text) &&
        validator(_emergencyPhoneController.text) &&
        validator(_wbPhoneController.text)) {
      configuration.name = _userNameController.text;
      configuration.ePhoneNumber = _emergencyPhoneController.text;
      configuration.phoneNumber = _wbPhoneController.text;
      print('enviado');
    }
  }

  Widget _userFormField() {
    return TextFormField(
      autocorrect: true,
      autofocus: true,
      focusNode: _currentUserFocusNode,
      controller: _userNameController,
      key: _formKeyUserName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emergencyPhoneFocusNode.requestFocus(),
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Ingrese un nombre',
        labelText: 'Nombre',
      ),
      validator: (String value) {
        return value.isEmpty ? 'Por favor ingrese un Nombre' : null;
      },
    );
  }

  Widget _ePhoneFormField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      focusNode: _emergencyPhoneFocusNode,
      controller: _emergencyPhoneController,
      key: _formKeyEmergencyPhone,
      onEditingComplete: () => _wbFocusNode.requestFocus(),
      decoration: const InputDecoration(
        icon: Icon(Icons.phone_callback),
        hintText: 'Ingrese una numero telefónico valido',
        labelText: 'teléfono',
      ),
      validator: (String value) {
        return value.isEmpty
            ? 'Por favor ingrese un numero telefónico valido'
            : null;
      },
    );
  }

  Widget _wbPhoneFormField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      focusNode: _wbFocusNode,
      controller: _wbPhoneController,
      key: _formKeyWBPhone,
      onEditingComplete: () => _submit(widget.channel),
      decoration: const InputDecoration(
        icon: Icon(Icons.phone_enabled_outlined),
        hintText: 'Ingrese una numero telefónico valido',
        labelText: 'teléfono',
      ),
      validator: (String value) {
        return value.isEmpty
            ? 'Por favor ingrese un numero telefónico valido'
            : null;
      },
    );
  }
}
