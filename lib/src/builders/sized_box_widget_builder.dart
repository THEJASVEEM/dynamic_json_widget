import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class SizedBoxWidgetBuild extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener, StreamController streamController) {
    return SizedBox(
      width: map['width'] != null ? double.parse(map['width']) : null,
      height: map['height'] != null ? double.parse(map['height']) : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener, streamController),
    );
  }

  @override
  String get widgetName => "SizedBox";

  @override
  Type get widgetType => SizedBox;
}
