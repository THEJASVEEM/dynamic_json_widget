import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class ContainerWidgetBuilder extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    Alignment? alignment = parseAlignment(map['alignment']);
    BoxConstraints constraints = parseBoxConstraints(map['constraints']);
    EdgeInsetsGeometry? margin = parseEdgeInsetsGeometry(map['margin']);
    EdgeInsetsGeometry? padding = parseEdgeInsetsGeometry(map['padding']);
    Map<String, dynamic>? childMap = map['child'];
    BoxDecoration? decoration =
        parseBoxDecoration(map["decoration"], buildContext);

    if (map.containsKey('decoration') && map['decoration']['color'] == null) {
      decoration = decoration.copyWith(
          color: parseThemeColor('onPrimaryContainer', buildContext));
    }

    Widget? child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(
            childMap,
            buildContext,
            listener,
            streamController,
          );

    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : null;

    var containerWidget = Container(
      decoration: decoration,
      alignment: alignment,
      padding: padding,
      margin: margin,
      width: map['width'] != null ? parseSize(map['width']) : null,
      height: map['height'] != null ? parseSize(map['height']) : null,
      constraints: constraints,
      child: child,
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(map['click_event']);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }

  @override
  String get widgetName => "Container";

  @override
  Type get widgetType => Container;
}
