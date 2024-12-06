import 'package:flutter/material.dart';
import 'package:ws_task/models/level_result.dart';
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
    return Column(
      children: [
        for (String str in levelResult.field)
          Expanded(
              child: Row(
            children: [
              for (int i = 0; i < str.length; i++)
                Expanded(
                  child: Text(
                    str[i],
                    textAlign: TextAlign.center,
                  ),
                )
            ],
          ))
      ],
    );
  }
}
