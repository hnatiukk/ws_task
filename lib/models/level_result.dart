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

  @override
  String toString() {
    return 'LevelResult{id: $id, result: $result}';
  }
}

class Result {
  List<Point> steps;
  String get path {
    if (steps.isEmpty) return '';
    return steps.map((point) => '(${point.x},${point.y})').join('->');
  }

  Result({required this.steps});

  @override
  String toString() {
    return 'Result{steps: $steps, path: $path}';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['steps'] = steps
        .map(
          (step) => step.toJson(),
        )
        .toList();
    json['path'] = path;
    return json;
  }
}
