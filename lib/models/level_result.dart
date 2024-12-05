import 'package:ws_task/models/point.dart';

class LevelResult {
  String id;
  Result result;

  LevelResult({required this.id, required this.result});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['result'] = result.toJson();
    return json;
  }
}

sealed class Result {
  List<Point> steps;
  String path;

  Result({required this.steps, required this.path});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['steps'] = steps.map((step) => step.toJson(),).toList();
    json['path'] = path;
    return json;
  }
}