import 'package:ws_task/models/point.dart';

class Level {
  String id;
  List<String> field;
  Point start;
  Point end;

  Level.fromJson(Map<String, dynamic> json)
  : id = json['id'],
  field = List<String>.from(json['field']),
  start = Point.fromJson(json['start']),
  end = Point.fromJson(json['end']);
}