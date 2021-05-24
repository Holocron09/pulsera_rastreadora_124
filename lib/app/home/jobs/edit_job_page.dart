import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulsera_rastreadora_124/app/home/models/Jobs.dart';
import 'package:pulsera_rastreadora_124/commonWidget/platform_exception_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/commonWidget/plattform_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/services/database.dart';
import 'dart:async';

class EditJobPage extends StatefulWidget {
  const EditJobPage({
    @required this.database,
    this.job,
  });
  final Database database;
  final Job job;

  static Future<void> show(
    BuildContext context, {
    Database database,
    Job job,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditJobPage(
          database: database,
          job: job,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final FocusNode _jobFocusNode = FocusNode();
  final FocusNode _ratePerHourFocusNode = FocusNode();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _ratePerHourController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _name;
  int _ratePerHour;
  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (widget.job != null) {
          allNames.remove(widget.job.name);
        }
        if (allNames.contains(_name)) {
          PlatformAlertDialog(
            title: 'Name already used\n',
            content: 'Please choose a diferent job name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job = Job(id: id, name: _name, ratePerHour: _ratePerHour);
          await widget.database.setJob(job);
          Navigator.of(context).pop();
          //dispose();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation Failed\n',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job.name;
      _ratePerHour = widget.job.ratePerHour;
      //_jobController.value=_name;
      //_ratePerHourController.value=_ratePerHour;
    }
  }

/*
  void dispose(){
    _jobController.dispose();
    _ratePerHourController.dispose();
    :super dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ? 'New Job' : 'Edit Job'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.indigo),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  void _jobEditingComplete(String jobName) {
    final newFocus = jobName.isEmpty ? _jobFocusNode : _ratePerHourFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job name'),
        initialValue: _name,
        //controller: _jobController,
        focusNode: _jobFocusNode,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
        onEditingComplete: () => _jobEditingComplete(_jobController.value.text),
        textInputAction: TextInputAction.next,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Rate per hour'),
        initialValue: _ratePerHour != null ? '$_ratePerHour' : null,
        //controller: _ratePerHourController,
        focusNode: _ratePerHourFocusNode,
        onEditingComplete: _submit,
        onSaved: (value) => _ratePerHour = int.tryParse(value) ?? 0,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
      ),
    ];
  }
}
