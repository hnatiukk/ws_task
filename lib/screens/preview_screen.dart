import 'package:flutter/material.dart';
import 'package:ws_task/models/level_result.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen(this.levelResult, {super.key});

  final LevelResult levelResult;

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
