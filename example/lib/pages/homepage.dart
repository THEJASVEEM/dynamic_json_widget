import 'dart:convert';
import 'dart:developer';

import 'package:example/material_widget.dart';
import 'package:example/provider/search_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? json;
  Map<String, dynamic>? map;
  bool error = false;
  String? errorMessage;

  @override
  void initState() {
    parseJsonFromAssets('assets/json/homepage.json');
    super.initState();
  }

  ///[parseJsonFromAssets] fetchs the json for the page from
  ///bundle assets and decodes it into map and initializes it to the
  ///[SeacrhChangeNotifier]
  Future<void> parseJsonFromAssets(String assetsPath) async {
    try {
      String jsonData = await rootBundle.loadString(assetsPath);
      setState(() {
        json = jsonData;
        map = jsonDecode(jsonData);
        final dataModel =
            Provider.of<SeacrhChangeNotifier>(context, listen: false);
        dataModel.fetchData(jsonData);
        error = false;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        error = true;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      /// If the JSON is not parsed through the builder
      /// an ErrorPlaceHolder is returned
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: Center(child: Placeholder(child: Text(errorMessage!)))));
    }
    if (json == null && map == null) {
      /// [CircularProgressIndicator] is shown until the
      /// JSON file is loaded
      return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: Center(child: CircularProgressIndicator())));
    }

    return MaterialWidget(json: json!, theme: map!['app']['theme']);
  }
}
