import 'package:flutter/material.dart';
import 'package:pulsera_rastreadora_124/commonWidget/Form_submit_button.dart';

class ShowProfile extends StatefulWidget {
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _wristBandPhoneController =
      TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _ageFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _wristBandPhoneFocusNode = FocusNode();

  String get _name => _nameController.text;
  String get _phone => _phoneController.text;
  String get _age => _ageController.text;
  String get _wristBandPhone => _wristBandPhoneController.text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
      SizedBox(
        height: 10,
      ),
      Icon(
        Icons.person,
        size: 50.0,
      ),
      _buildNameTextField(),
      _buildAgeTextField(),
      _buildPhoneTextField(),
      _buildWristbandPhoneTextField(),
      SizedBox(
        height: 20,
      ),
      FormSubmitButton(
        text: "Guardar",
        onPressed: () {},
      ),
    ];
  }

  TextField _buildNameTextField() {
    return TextField(
      controller: _nameController,
      focusNode: _nameFocusNode,
      decoration: InputDecoration(
        labelText: "Nombre",
        hintText: "Nombre",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorText: _name.isEmpty ? "Porfavor ingrese un nombre valido" : null,
      ),
      autocorrect: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (name) => _updateState(),
      onEditingComplete: _nameEditingComplete,
    );
  }

  TextField _buildAgeTextField() {
    return TextField(
      controller: _ageController,
      focusNode: _ageFocusNode,
      decoration: InputDecoration(
        labelText: "Edad",
        hintText: "Edad",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorText: _age.isEmpty ? "Porfavor ingrese una edad valida" : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onChanged: (age) => _updateState(),
      onEditingComplete: _ageEditingComplete,
    );
  }

  TextField _buildPhoneTextField() {
    return TextField(
      controller: _phoneController,
      focusNode: _phoneFocusNode,
      decoration: InputDecoration(
        labelText: "Número de telefono",
        hintText: "Número de telefono",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorText:
            _age.isEmpty ? "Porfavor ingrese su numero de telefono" : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onChanged: (phone) => _updateState(),
      onEditingComplete: _phoneEditingComplete,
    );
  }

  TextField _buildWristbandPhoneTextField() {
    return TextField(
      controller: _wristBandPhoneController,
      focusNode: _wristBandPhoneFocusNode,
      decoration: InputDecoration(
        labelText: "Número de telefono de la pulsera",
        hintText: "Teléfono de la pulsera",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorText: _wristBandPhone.isEmpty
            ? "Porfavor ingrese el numero de telefono de la pulsera"
            : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onChanged: (phone) => _updateState(),
      onEditingComplete: _wristBandPhoneEditingComplete,
    );
  }

  @override
  void dispose() {
    _wristBandPhoneFocusNode.dispose();
    _wristBandPhoneController.dispose();
    _phoneFocusNode.dispose();
    _phoneController.dispose();
    _nameFocusNode.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _ageFocusNode.dispose();
    super.dispose();
  }

  void _nameEditingComplete() {
    final newFocus = _name.isNotEmpty ? _ageFocusNode : _nameFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _phoneEditingComplete() {
    final newFocus =
        _phone.isNotEmpty ? _wristBandPhoneFocusNode : _phoneFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _ageEditingComplete() {
    final newFocus = _age.isNotEmpty ? _phoneFocusNode : _ageFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _wristBandPhoneEditingComplete() {
    final newFocus =
        _wristBandPhone.isNotEmpty ? null : _wristBandPhoneFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _updateState() {
    setState(() {});
  }
}
