import 'package:flutter/foundation.dart';

class ChildEntry {
  ChildEntry({
    @required this.id,
    @required this.name,
    @required this.latitude,
    @required this.longitude,
  });
  String id;
  String name;
  String latitude;
  String longitude;

  factory ChildEntry.fromMap(Map<dynamic, dynamic> value, String id) {
    return ChildEntry(
      id: id,
      name: value['children'],
      latitude: value['latitude'],
      longitude: value['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
