import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class HeaderWidgetBuilder extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    var headerMap = parseHeaderJson(map);
    Widget? headerWidget = DynamicWidgetBuilder.buildFromMap(
      headerMap,
      buildContext,
      listener,
      streamController,
    );
    return headerWidget!;
  }

  @override
  String get widgetName => 'Header';

  @override
  Type get widgetType => HeaderWidgetBuilder;
}
