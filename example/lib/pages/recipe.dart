import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:example/homepage_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nymble_dynamic_widgets/dynamic_widget_json_container.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  String? json;
  Map<String, dynamic>? map;
  bool error = false;
  String? errorMessage;
  late DynamicWidgetContainer? exportor;
  final _streamController = StreamController<MapEntry<Key, String>>();
  final _widgetRegistry = <Key, String>{};
  late StreamSubscription<MapEntry<Key, String>> _streamSubscription;

  @override
  void initState() {
    parseJsonFromAssets('assets/json/recipe.json');
    _streamSubscription = _streamController.stream.listen((entry) {
      setState(() {
        _widgetRegistry[entry.key] = entry.value;
      });
    });
    super.initState();
  }

  Future<void> parseJsonFromAssets(String assetsPath) async {
    log('--- Parse json from: $assetsPath');

    try {
      String jsonData = await rootBundle.loadString(assetsPath);
      setState(() {
        json = jsonData;
        map = jsonDecode(jsonData);
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
  void dispose() {
    _streamController.close();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Scaffold(
          body: Center(child: Placeholder(child: Text(errorMessage!))));
    }
    if (json == null && map == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: FutureBuilder<Widget?>(
        future: _buildWidget(context, map!),
        builder: (BuildContext context, AsyncSnapshot<Widget?> snapshot) {
          if (snapshot.hasError) {
            log(snapshot.error.toString());
          }

          return snapshot.hasData
              ? exportor = DynamicWidgetContainer(
                  child: snapshot.data,
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<Widget?> _buildWidget(
      BuildContext context, Map<String, dynamic> map) async {
    return DynamicWidgetBuilder.build(
      map,
      context,
      DefaultClickListener(context: context),
      _streamController,
    );
  }
}
