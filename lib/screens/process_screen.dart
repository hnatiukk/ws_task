import 'package:flutter/material.dart';
import 'package:ws_task/api/level_api.dart';
import 'package:ws_task/models/api_response.dart';
import 'package:ws_task/models/level.dart';
import 'package:ws_task/models/level_result.dart';
import 'package:ws_task/screens/result_list_screen.dart';
import 'package:ws_task/services/calculations_service.dart';
import 'package:ws_task/utils/constants.dart';
import 'package:ws_task/utils/messages.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen(this.levels, {super.key});

  final List<Level> levels;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  final LevelApi _levelApi = LevelApi();
  final CalculationsService _calculationsService = CalculationsService();
  bool _isProcessingCalculations = true;
  bool _isSendingResults = false;
  double _calculationPercentage = 0;
  final List<LevelResult> _levelResults = [];

  @override
  void initState() {
    _doCalculations();
    super.initState();
  }

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
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isProcessingCalculations
                        ? 'Processing calculations...'
                        : 'All calculations has finished, you can send your results to server',
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  Text('$_calculationPercentage%'),
                  const Divider(),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  if (_isSendingResults) const CircularProgressIndicator()
                ],
              ),
            )),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isProcessingCalculations || _isSendingResults
                    ? null
                    : _sendResults,
                child: const Text('Send results to server'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendResults() async {
    setState(() {
      _isSendingResults = true;
    });

    ApiResponse response = await _levelApi.sendResults(_levelResults);

    if (response.error) {
      showErrorMessage(response.message, context);
      setState(() {
        _isSendingResults = false;
      });
      return;
    }
    setState(() {
      _isSendingResults = false;
    });

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ResultListScreen(_levelResults),
    ));
  }

  void _doCalculations() {
    setState(() {
      _isProcessingCalculations = true;
    });

    // кожен рівень буде додавати до відсотка завантаження сталий відсоток,
    // наприклад: 5 рівнів - кожень рівень додає по 20% після свого обрахунку
    double levelPercentage = 100 / widget.levels.length;

    for (Level level in widget.levels) {
      Result result = _calculationsService.calculateResult(level);
      _levelResults
          .add(LevelResult(id: level.id, result: result, field: level.field));
      setState(() {
        _calculationPercentage += levelPercentage;
      });
    }

    setState(() {
      _isProcessingCalculations = false;
    });
  }
}
