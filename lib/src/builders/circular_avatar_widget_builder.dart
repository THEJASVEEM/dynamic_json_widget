import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class CircularAvatarWidgetBuilder extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : null;
    String image = map['image'];
    String path = map['path'];

    var containerWidget = CircleAvatar(
      radius: path == 'asset' ? 24 : 30,
      backgroundImage: path == 'asset'
          ? AssetImage(image)
          : NetworkImage(image, scale: 0.5) as ImageProvider,
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
  String get widgetName => "CircularAvatar";

  @override
  Type get widgetType => CircleAvatar;
}
