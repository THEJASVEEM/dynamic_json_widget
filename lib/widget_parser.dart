import 'dart:async';

import 'package:flutter/material.dart';

///[WidgetParser] used as a blueprint for the Builders
///
///[WidgetParser] to be extended in order to have custom
///builders or parsers
///
/// the widget type name for example:
///
/// {
///
///   "type": "Text",
///
///   "data": "New Recipe",
///
///   "maxLines": 3,
///
///   "overflow": "ellipsis",
///
///   "style": {
///
///     "fontSize": "10.s",
///
///     "themeColor":"onSurfaceVariant"
///
///   }
///
/// }
///
abstract class WidgetParser {
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  );

  ///[widgetName] is used in JSON to parse
  String get widgetName;

  /// Define a type to the widget builder
  Type get widgetType;
}

abstract class ClickListener {
  void onClicked(String? event);
}
