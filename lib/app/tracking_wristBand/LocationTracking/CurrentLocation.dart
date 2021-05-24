import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/firebase_Database.dart';
import 'package:pulsera_rastreadora_124/app/tracking_wristBand/location/LocationCard.dart';

class CurrentLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<ReadFirebaseDatabase>(context);
    bool listEmpty;
    List _childrenList = [];

    void getChildrenList() async {
      _childrenList = await database.getChildrenList();
      print('ChildrenList async= $_childrenList');
    }

    return FutureBuilder<List>(
      future: database.getChildrenList(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        print(snapshot.data);
        snapshot.data == null ? listEmpty = true : listEmpty = false;

        //TODO
        /*Si la lista esta vacia se debe informar que esta vacia en vez de mostrar una pagina en blanco*/
        return ListView.builder(
          itemCount: listEmpty ? 1 : snapshot.data.length,
          itemBuilder: (context, int i) {

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListTile(
                onTap: listEmpty
                    ? null
                    : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            maintainState: true,
                            fullscreenDialog: false,
                            builder: (context) => ChildCurrentLocation(
                              childName: database.list[i],
                            ),
                          ),
                        );
                      },
                leading: CircleAvatar(
                  child: Icon(Icons.person_outline),
                ),
                title: Text(' ${database.list[i]}'),
                trailing: listEmpty ? null : Icon(Icons.chevron_right),
              ),
            );
          },
        );
      },
    );
  }
}
