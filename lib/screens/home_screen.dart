import 'package:flutter/material.dart';
import 'package:ws_task/api/level_api.dart';
import 'package:ws_task/models/api_response.dart';
import 'package:ws_task/models/level.dart';
import 'package:ws_task/utils/constants.dart';
import 'package:ws_task/utils/messages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController urlController = TextEditingController();

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set valid API base URL in order to continue'),
            TextField(
              controller: urlController,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: getLevelsAndCalculate,
                child: const Text('Start counting process'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getLevelsAndCalculate() async {
    baseUrl = urlController.text;

    LevelApi levelApi = LevelApi();
    ApiResponse response = await levelApi.fetchLevels();

    if (response.error) {
      showErrorMessage(response.message, context);
      return;
    }

    List<Level> fetchedLevels = [];
    for (var level in response.data as List<dynamic>) {
      fetchedLevels.add(Level.fromJson(level));
    }

    //todo: jump to next screen

    calculateResults(fetchedLevels);
  }

  void calculateResults(List<Level> fetchedLevels) {

  }
}
