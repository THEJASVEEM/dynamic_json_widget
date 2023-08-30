import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/builders/banner_carousel_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/banner_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/box_item_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/center_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/circular_avatar_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/circular_item_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/container_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/expanded_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/header_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/horizontal_list_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/icon_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/listview_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/row_column_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/search_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/sized_box_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/stack_widget_builder.dart';
import 'package:nymble_dynamic_widgets/src/builders/text_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class DynamicWidgetBuilder {
  static final parsers = [
    ContainerWidgetBuilder(),
    TextWidgetBuilder(),
    RowWidgetBuilder(),
    ColumnWidgetBuilder(),
    BannerWidgetBuilder(),
    CircularAvatarWidgetBuilder(),
    HeaderWidgetBuilder(),
    SearchWidgetBuilder(),
    CircularItemWidgetBuilder(),
    BoxItemWidgetBuilder(),
    BannerCarouselWidgetBuilder(),
    HorizontalListWidgetBuilder(),
    ListViewWidgetBuilder(),
    IconWidgetBuilder(),
    CenterWidgetBuilder(),
    StackWidgetBuild(),
    SizedBoxWidgetBuild(),
    ExpandedWidgetBuilder()
  ];

  static final widgetNameParserMap = <String, WidgetParser>{};

  static bool _defaultParserInited = false;

  //[addParser] used for adding custom parser
  static void addParser(WidgetParser parser) {
    ///Add custom widget parser
    ///Make sure not to override widget type

    parsers.add(parser);
    widgetNameParserMap[parser.widgetName] = parser;
  }

  ///Function to initialize the [widgetNameParserMap] with default
  ///WidgetBuilders
  static void initDefault() {
    if (!_defaultParserInited) {
      for (var parser in parsers) {
        widgetNameParserMap[parser.widgetName] = parser;
      }
      _defaultParserInited = true;
    }
  }

  /// Method to call the build using JSON or map
  static Widget? build(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener listener,
    StreamController<MapEntry<Key, String>> streamController,
  ) {
    initDefault();
    var widget = buildFromMap(map, buildContext, listener, streamController);
    return widget;
  }

  static Widget? buildFromMap(
      Map<String, dynamic>? map,
      BuildContext buildContext,
      ClickListener? listener,
      StreamController streamController) {
    initDefault();
    if (map == null) {
      return null;
    }
    String? widgetName = map['type'];
    if (widgetName == null) {
      return null;
    }
    var parser = widgetNameParserMap[widgetName];
    if (parser != null) {
      return parser.parse(map, buildContext, listener, streamController);
    }
    return null;
  }

  ///Builds multiple widgets and wraps it in list
  ///in case there are multiple children widgets
  static List<Widget> buildWidgets(
      List<dynamic> values,
      BuildContext buildContext,
      ClickListener? listener,
      StreamController streamController) {
    initDefault();
    List<Widget> widgets = [];
    for (var value in values) {
      var buildFromMap2 = buildFromMap(
        value,
        buildContext,
        listener,
        streamController,
      );
      if (buildFromMap2 != null) {
        widgets.add(buildFromMap2);
      }
    }
    return widgets;
  }
}
