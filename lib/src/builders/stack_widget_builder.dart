import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class StackWidgetBuild extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener, StreamController streamController) {
    return Stack(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])!
          : AlignmentDirectional.topStart,
      textDirection: map.containsKey("textDirection")
          ? parseTextDirection(map["textDirection"])
          : null,
      fit: map.containsKey("fit") ? parseStackFit(map["fit"])! : StackFit.loose,
      clipBehavior: map.containsKey("clipBehavior")
          ? parseClip(map["clipBehavior"])!
          : Clip.hardEdge,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener, streamController),
    );
  }

  @override
  String get widgetName => "Stack";

  @override
  Type get widgetType => Stack;
}
