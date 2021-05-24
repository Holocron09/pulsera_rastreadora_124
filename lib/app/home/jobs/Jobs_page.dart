import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:pulsera_rastreadora_124/app/home/job_entries/job_entries_page.dart';
import 'package:pulsera_rastreadora_124/app/home/jobs/edit_job_page.dart';
import 'package:pulsera_rastreadora_124/app/home/jobs/job_list_tile.dart';
import 'package:pulsera_rastreadora_124/app/home/jobs/list_item_builder.dart';
import 'package:pulsera_rastreadora_124/app/home/models/Jobs.dart';
import 'package:pulsera_rastreadora_124/commonWidget/platform_exception_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/commonWidget/plattform_alert_dialog.dart';
import 'package:pulsera_rastreadora_124/services/Auth.dart';
import 'package:pulsera_rastreadora_124/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Log Out',
      content: 'Are you sure that you want to logout? ',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context);
      await database.deleteJob(job);
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(
          context,
          database: Provider.of<Database>(context),
        ),
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.grey[100],
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => _delete(context, job),
            child: JobListTile(
              job: job,
              onTap: () => JobEntriesPage.show(context, job),
            ),
          ),
        );
      },
    );
  }
}
