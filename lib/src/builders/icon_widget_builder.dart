import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/icon_helper.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class IconWidgetBuilder extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    return Icon(
      map.containsKey('data')
          ? getIconUsingPrefix(name: map['data'])
          : Icons.android,
      size: map.containsKey("size") ? map['size']?.toDouble() : null,
      color: map.containsKey('themeColor')
          ? parseThemeColor(map['themeColor'], buildContext)
          : map.containsKey('color')
              ? parseHexColor(map['color'])
              : null,
      semanticLabel:
          map.containsKey('semanticLabel') ? map['semanticLabel'] : null,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
    );
  }

  @override
  String get widgetName => "Icon";

  @override
  Type get widgetType => Icon;
}
