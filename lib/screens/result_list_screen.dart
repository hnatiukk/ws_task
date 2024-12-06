import 'package:flutter/material.dart';
import 'package:ws_task/models/level_result.dart';
import 'package:ws_task/screens/preview_screen.dart';
import 'package:ws_task/utils/constants.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen(this.levelResults, {super.key});

  final List<LevelResult> levelResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Process screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: ListView.builder(
          itemCount: levelResults.length,
          itemBuilder: (context, index) {
            LevelResult levelResult = levelResults[index];

            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  levelResult.result.path,
                  textAlign: TextAlign.center,
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PreviewScreen(levelResult),
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
