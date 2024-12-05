import 'package:flutter/material.dart';
import 'package:ws_task/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
    home: const HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
