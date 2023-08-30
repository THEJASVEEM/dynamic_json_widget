import 'dart:async';
import 'dart:developer';

import 'package:example/provider/search_change_notifier.dart';
import 'package:example/pages/recipe.dart';
import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/dynamic_widget_json_container.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';
import 'package:provider/provider.dart';

class HomePageBuilder extends StatefulWidget {
  const HomePageBuilder({Key? key, required this.jsonString}) : super(key: key);

  final String jsonString;

  @override
  State<HomePageBuilder> createState() => _HomePageBuilderState();
}

class _HomePageBuilderState extends State<HomePageBuilder> {
  late DynamicWidgetContainer? exportor;
  final _streamController = StreamController<MapEntry<Key, String>>();
  final _widgetRegistry = <Key, String>{};
  late StreamSubscription<MapEntry<Key, String>> _streamSubscription;

  _HomePageBuilderState();

  @override
  void initState() {
    ///Listens to all the changes and adds the changed value to the
    ///[_widgetRegistry] <Key, String>{}; map
    _streamSubscription = _streamController.stream.listen((entry) {
      setState(() {
        _widgetRegistry[entry.key] = entry.value;
      });
      var searchKey = const Key('search_recipes');
      if (searchKey == entry.key) {
        Provider.of<SeacrhChangeNotifier>(context, listen: false)
            .searchData(_widgetRegistry[entry.key]!);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<SeacrhChangeNotifier>(
          builder: (context, state, child) {
            if (state.mapJson.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return FutureBuilder<Widget?>(
              future: _buildWidget(context, state.mapJson),
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
            );
          },
        ),
      ),
    );
  }

  ///[DynamicWidgetBuilder] from the framework is used to take
  ///in the [Map] from the `JSON` and renders the widgets
  ///
  ///Takes in a [DefaultClickListener] to respond to all the onTap
  ///calls could be customised based on the events pased through
  ///JSON and handle the event
  ///
  ///Takes in a [StreamController] for listening to all the widgets
  ///that change the value and add those the [_widgetRegistry] map
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

class DefaultClickListener implements ClickListener {
  BuildContext context;
  DefaultClickListener({
    required this.context,
  });
  @override
  void onClicked(String? event) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Recipe()));
    log("Receive click event: ${event ?? ""}");
  }
}
