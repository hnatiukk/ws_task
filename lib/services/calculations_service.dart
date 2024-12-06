import 'package:flutter/cupertino.dart';
import 'package:ws_task/models/level.dart';
import 'package:ws_task/models/level_result.dart';
import 'package:ws_task/models/point.dart';

class CalculationsService {
  Result calculateResult(Level level) {
    Path bestPath = Path();
    // обмеження сітки 100x100
    bestPath.length = 9999;
    // знайде лише 1 найркащий результат
    findBestPath(level.start, level.end, level.field, Path(), bestPath);

    return Result(steps: bestPath.steps);
  }

  // 8 можливих напрямків навколо точки
  final directions = [
    Point(-1, -1), Point(-1, 0), Point(-1, 1),
    Point(0, 1),                 Point(1, 1),
    Point(1, 0), Point(1, -1),   Point(0, -1),
  ];

  // bool, бо коли вертаєм true вже знайшли перескок з цієї точки, зовнішні навколо неї немає сенсу перевіряти
  bool findBestPath(Point point, Point end, List<String> field,
      Path currentPath, Path bestPath) {
    debugPrint(point.toString());
    debugPrint('end is $end');

    if (currentPath.length + 1 > bestPath.length) return false;

    currentPath.steps.add(point);
    if (point == end) {
      debugPrint('path found: $currentPath');
      if (currentPath.length < bestPath.length) {
        bestPath.length = currentPath.length;
        bestPath.steps = List.from(currentPath.steps);
      }
      currentPath.steps.removeLast();
      return true;
    }
    currentPath.length++;

    for (Point direction in directions) {
      final nextPoint = Point(point.x + direction.x, point.y + direction.y);

      if (nextPoint.x >= 0 &&
          nextPoint.x < field.length &&
          nextPoint.y >= 0 &&
          nextPoint.y < field[nextPoint.x].length &&
          field[nextPoint.x][nextPoint.y] != 'X' &&
          !currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.removeLast();
          return false;
        }
      }
    }

    currentPath.length--;
    currentPath.steps.removeLast();
    return false;
  }

}

class Path {
  List<Point> steps = [];
  int length = 0;

  @override
  String toString() {
    return 'Path{steps: $steps, length: $length}';
  }
}
