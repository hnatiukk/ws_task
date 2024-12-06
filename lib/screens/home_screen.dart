import 'package:flutter/material.dart';
import 'package:ws_task/api/level_api.dart';
import 'package:ws_task/models/api_response.dart';
import 'package:ws_task/models/level.dart';
import 'package:ws_task/screens/process_screen.dart';
import 'package:ws_task/utils/constants.dart';
import 'package:ws_task/utils/messages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LevelApi _levelApi = LevelApi();
  final TextEditingController _urlController = TextEditingController();
  bool _isLoadingLevels = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set valid API base URL in order to continue'),
            TextField(
              controller: _urlController,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    _isLoadingLevels ? null : getLevelsAndBeginCalculations,
                child: const Text('Start counting process'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getLevelsAndBeginCalculations() async {
    setState(() {
      _isLoadingLevels = true;
    });

    baseUrl = _urlController.text;

    ApiResponse response = await _levelApi.fetchLevels();

    if (response.error) {
      showErrorMessage(response.message, context);
      setState(() {
        _isLoadingLevels = false;
      });
      return;
    }

    List<Level> fetchedLevels = [];
    for (var level in response.data as List<dynamic>) {
      fetchedLevels.add(Level.fromJson(level));
    }

    setState(() {
      _isLoadingLevels = false;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProcessScreen(fetchedLevels),
    ));
  }
}
