import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/placeholder_widget.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class HorizontalListWidgetBuilder extends WidgetParser {
  String? errorMsg = '';
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    var horizontalListMap = parseHorizontalList(map);

    if (!validateWidgets(map, buildContext)) {
      return ErrorPlaceholderWidget(message: errorMsg!);
    } else {
      return DynamicWidgetBuilder.buildFromMap(
        horizontalListMap,
        buildContext,
        listener,
        streamController,
      )!;
    }
  }

  bool validateWidgets(Map<String, dynamic> map, BuildContext buildContext) {
    if (!map.containsKey('title')) {
      errorMsg = 'Horizontal list requires a title';
      return false;
    }

    return true;
  }

  @override
  String get widgetName => 'Horizontal_Lists';

  @override
  Type get widgetType => HorizontalListWidgetBuilder;
}
