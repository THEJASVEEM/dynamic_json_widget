import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class ExpandedWidgetBuilder extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener, StreamController streamController) {
    return Expanded(
      flex: map.containsKey("flex") ? map["flex"] : 1,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener, streamController)!,
    );
  }

  @override
  String get widgetName => "Expanded";

  @override
  Type get widgetType => Expanded;
}
