import 'package:example/pages/homepage.dart';
import 'package:example/provider/search_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeacrhChangeNotifier(),
      child: const MyHomePage(),
    );
  }
}
