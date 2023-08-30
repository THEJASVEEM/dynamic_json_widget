import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class BoxItemWidgetBuilder extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    EdgeInsetsGeometry? margin = parseEdgeInsetsGeometry("5,0,5,0");
    EdgeInsetsGeometry? padding = parseEdgeInsetsGeometry(map['padding']);

    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : null;

    var containerWidget = Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: parseThemeColor('secondaryContainer', buildContext),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          alignment: Alignment.center,
          padding: padding,
          margin: margin,
          width: 70,
          height: 90,
          child: Image.network(
            map['image'],
            fit: BoxFit.scaleDown,
            width: 70,
            height: 70,
          ),
        ),
        Text(
          map['text'],
          style: TextStyle(
            color: Theme.of(buildContext).colorScheme.onSurface,
          ),
        ),
      ],
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }

  @override
  String get widgetName => "BoxItem";

  @override
  Type get widgetType => BoxItemWidgetBuilder;
}
