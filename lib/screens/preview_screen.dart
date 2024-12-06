import 'package:flutter/material.dart';
import 'package:ws_task/models/level_result.dart';
import 'package:ws_task/models/point.dart';
import 'package:ws_task/utils/constants.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen(this.levelResult, {super.key});

  final LevelResult levelResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Preview screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: _resultField()),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            levelResult.result.path,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: defaultPadding,
          ),
          Text(
            levelResult.id,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _resultField() {
    Point startPoint = levelResult.result.steps.first;
    Point endPoint = levelResult.result.steps.last;
    List<Point> pathPoints = levelResult.result.steps.getRange(1, levelResult.result.steps.length - 1).toList();

    return Column(
      children: [
        for (int x = 0; x < levelResult.field.length; x++)
          Expanded(
            child: Row(
              children: [
                for (int y = 0; y < levelResult.field[x].length; y++)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: () {
                          Point currentPoint = Point(x, y);
                          if (currentPoint == startPoint) {
                            return startPointColor;
                          } else if (currentPoint == endPoint) {
                            return endPointColor;
                          } else if (pathPoints.contains(currentPoint)) {
                            return pathPointColor;
                          } else if (levelResult.field[x][y] == 'X') {
                            return blockedPointColor;
                          } else {
                            return emptyPointColor;
                          }
                        }(),
                      ),
                      alignment: Alignment.center,
                      height: double.infinity,

                      child: Text(
                        '($x, $y)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.purpleAccent),
                      ),
                    ),
                  )
              ],
            ),
          )
      ],
    );
  }
}
