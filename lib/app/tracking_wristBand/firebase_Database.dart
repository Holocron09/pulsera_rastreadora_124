import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:pulsera_rastreadora_124/services/api_path.dart';

abstract class HandleFirebaseDatabase {
  Future<List> getChildrenList();
  Future<List> getLocation(String childName);
  //Future<List<dynamic>> getListedChildren();
}

class ReadFirebaseDatabase implements HandleFirebaseDatabase {
  ReadFirebaseDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  double _latitude = 0.0;
  double _longitude = 0.0;
  List _listedChildren = ['Agregue a un usuario'];
  final databaseReference = FirebaseDatabase.instance.reference();

  get list => _listedChildren;
  get latitude => _latitude;
  get longitude => _longitude;

  @override
  Future<List> getChildrenList() async {
    List _listedChildren = [];
    try {
      await databaseReference
          .child(APIPath.listChildren(uid))
          .once()
          .then((DataSnapshot snapshot) {
        _listedChildren = (snapshot.value).keys.toList();
      });
    } catch (e) {
      print(e);
    }

    this._listedChildren = _listedChildren;
    return _listedChildren;
  }

  @override
  Future<List> getLocation(String childName) async {
    List _location = [];
    print('$uid');
    try {
      await databaseReference
          .child(APIPath.givenChildrenLocation(uid, childName))
          .once()
          .then((DataSnapshot snapshot) {
        print(snapshot.value);
        _latitude = snapshot.value['latitude'];
        _longitude = snapshot.value['longitude'];
        _location = [_latitude, _longitude];
      });
    } catch (e) {
      print(e);
    }
    print('ubicacion de $childName: $_location');
    return _location;
  }
}
