import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/placeholder_widget.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class BannerWidgetBuilder extends WidgetParser {
  String? _errorMsg = '';
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    var bannerMap = parseBannerJson(map);

    if (!validateWidgets(map, buildContext)) {
      return ErrorPlaceholderWidget(message: _errorMsg!);
    } else {
      return DynamicWidgetBuilder.buildFromMap(
        bannerMap,
        buildContext,
        listener,
        streamController,
      )!;
    }
  }

  bool validateWidgets(Map<String, dynamic> map, BuildContext buildContext) {
    if (!map.containsKey('color') && !map.containsKey('image')) {
      _errorMsg = 'Banner widget requires a color or a image as the background';
      return false;
    }

    if (!map.containsKey('header_text')) {
      _errorMsg = 'Banner requires a header_text';
      return false;
    }

    if (!map.containsKey('footer_text')) {
      _errorMsg = 'Banner requires a footer_text';
      return false;
    }
    return true;
  }

  @override
  String get widgetName => 'Banner';

  @override
  Type get widgetType => Banner;
}
