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

  // bool, бо коли вертаєм тру вже знайшли найокоротший перескок з цієї точки, зовнішні навколо неї немає сенсу перевіряти
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
        currentPath.steps.remove(point);
      }
      return true;
    }
    currentPath.length++;

    Point nextPoint;
    if (point.x - 1 >= 0 &&
        point.y - 1 >= 0 &&
        field[point.x - 1][point.y - 1] != 'X') {
      nextPoint = Point(point.x - 1, point.y - 1);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.x - 1 >= 0 && field[point.x - 1][point.y] != 'X') {
      nextPoint = Point(point.x - 1, point.y);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.x - 1 >= 0 &&
        point.y + 1 < field[point.x - 1].length &&
        field[point.x - 1][point.y + 1] != 'X') {
      nextPoint = Point(point.x - 1, point.y + 1);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.y + 1 < field[point.x].length &&
        field[point.x][point.y + 1] != 'X') {
      nextPoint = Point(point.x, point.y + 1);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.x + 1 < field.length &&
        point.y + 1 < field[point.x + 1].length &&
        field[point.x + 1][point.y + 1] != 'X') {
      nextPoint = Point(point.x + 1, point.y + 1);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.x + 1 < field.length && field[point.x + 1][point.y] != 'X') {
      nextPoint = Point(point.x + 1, point.y);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.x + 1 < field.length &&
        point.y - 1 >= 0 &&
        field[point.x + 1][point.y - 1] != 'X') {
      nextPoint = Point(point.x + 1, point.y - 1);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    if (point.y - 1 >= 0 && field[point.x][point.y - 1] != 'X') {
      nextPoint = Point(point.x, point.y - 1);
      if (!currentPath.steps.contains(nextPoint)) {
        if (findBestPath(nextPoint, end, field, currentPath, bestPath)) {
          currentPath.length--;
          currentPath.steps.remove(point);
          return false;
        }
      }
    }

    currentPath.length--;
    currentPath.steps.remove(point);
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
