import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/custom_schemas.dart';

TextAlign parseTextAlign(String? textAlignString) {
  //left the system decide
  TextAlign textAlign = TextAlign.start;
  switch (textAlignString) {
    case "left":
      textAlign = TextAlign.left;
      break;
    case "right":
      textAlign = TextAlign.right;
      break;
    case "center":
      textAlign = TextAlign.center;
      break;
    case "justify":
      textAlign = TextAlign.justify;
      break;
    case "start":
      textAlign = TextAlign.start;
      break;
    case "end":
      textAlign = TextAlign.end;
      break;
    default:
      textAlign = TextAlign.start;
  }
  return textAlign;
}

TextOverflow? parseTextOverflow(String? textOverflowString) {
  TextOverflow? textOverflow;
  switch (textOverflowString) {
    case "ellipsis":
      textOverflow = TextOverflow.ellipsis;
      break;
    case "clip":
      textOverflow = TextOverflow.clip;
      break;
    case "fade":
      textOverflow = TextOverflow.fade;
      break;
    default:
      textOverflow = TextOverflow.fade;
  }
  return textOverflow;
}

TextDecoration parseTextDecoration(String? textDecorationString) {
  TextDecoration textDecoration = TextDecoration.none;
  switch (textDecorationString) {
    case "lineThrough":
      textDecoration = TextDecoration.lineThrough;
      break;
    case "overline":
      textDecoration = TextDecoration.overline;
      break;
    case "underline":
      textDecoration = TextDecoration.underline;
      break;
    case "none":
    default:
      textDecoration = TextDecoration.none;
  }
  return textDecoration;
}

TextDirection parseTextDirection(String? textDirectionString) {
  TextDirection textDirection = TextDirection.ltr;
  switch (textDirectionString) {
    case 'ltr':
      textDirection = TextDirection.ltr;
      break;
    case 'rtl':
      textDirection = TextDirection.rtl;
      break;
    default:
      textDirection = TextDirection.ltr;
  }
  return textDirection;
}

FontWeight parseFontWeight(String? textFontWeight) {
  FontWeight fontWeight = FontWeight.normal;
  switch (textFontWeight) {
    case 'w100':
      fontWeight = FontWeight.w100;
      break;
    case 'w200':
      fontWeight = FontWeight.w200;
      break;
    case 'w300':
      fontWeight = FontWeight.w300;
      break;
    case 'normal':
    case 'w400':
      fontWeight = FontWeight.w400;
      break;
    case 'w500':
      fontWeight = FontWeight.w500;
      break;
    case 'w600':
      fontWeight = FontWeight.w600;
      break;
    case 'bold':
    case 'w700':
      fontWeight = FontWeight.w700;
      break;
    case 'w800':
      fontWeight = FontWeight.w800;
      break;
    case 'w900':
      fontWeight = FontWeight.w900;
      break;
    default:
      fontWeight = FontWeight.normal;
  }
  return fontWeight;
}

Color? parseThemeColor(String? colorScheme, BuildContext context) {
  switch (colorScheme) {
    case 'primary':
      return Theme.of(context).colorScheme.primary;
    case 'background':
      return Theme.of(context).colorScheme.background;
    case 'primaryContainer':
      return Theme.of(context).colorScheme.primaryContainer;
    case 'onBackground':
      return Theme.of(context).colorScheme.onBackground;
    case 'secondaryContainer':
      return Theme.of(context).colorScheme.secondaryContainer;
    case 'onSurface':
      return Theme.of(context).colorScheme.onSurface;
    case 'onSurfaceVariant':
      return Theme.of(context).colorScheme.onSurfaceVariant;
    default:
      Theme.of(context).colorScheme.primary;
  }
  return null;
}

Color? parseHexColor(String? hexColorString) {
  if (hexColorString == null) {
    return null;
  }
  hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
  if (hexColorString.length == 6) {
    hexColorString = "FF$hexColorString";
  }
  int colorInt = int.parse(hexColorString, radix: 16);
  return Color(colorInt);
}

Color? parseHexColorWithOpacity(String? hexColorString, String? opacity) {
  if (hexColorString == null) {
    return null;
  }
  if (opacity == null) {
    return null;
  }

  hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
  if (hexColorString.length == 6) {
    hexColorString = "FF$hexColorString";
  }
  int colorInt = int.parse(hexColorString, radix: 16);
  return Color(colorInt).withOpacity(double.parse(opacity));
}

TextStyle? parseTextStyle(Map<String, dynamic>? map) {
  if (map == null) {
    return null;
  }

  Color? colorValue;
  String? color;
  if (map['color'] is int) {
    colorValue = Color(map['color']);
  } else {
    color = map['color'];
  }
  String? debugLabel = map['debugLabel'];
  String? decoration = map['decoration'];
  String? fontFamily = map['fontFamily'];
  String? fontSize = map['fontSize'];
  String? fontWeight = map['fontWeight'];
  FontStyle fontStyle =
      'italic' == map['fontStyle'] ? FontStyle.italic : FontStyle.normal;

  return TextStyle(
    color: colorValue ?? parseHexColor(color),
    debugLabel: debugLabel,
    decoration: parseTextDecoration(decoration),
    fontSize: parseSize(fontSize),
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    fontWeight: parseFontWeight(fontWeight),
  );
}

Alignment? parseAlignment(String? alignmentString) {
  Alignment? alignment;
  switch (alignmentString) {
    case 'topLeft':
      alignment = Alignment.topLeft;
      break;
    case 'topCenter':
      alignment = Alignment.topCenter;
      break;
    case 'topRight':
      alignment = Alignment.topRight;
      break;
    case 'centerLeft':
      alignment = Alignment.centerLeft;
      break;
    case 'center':
      alignment = Alignment.center;
      break;
    case 'centerRight':
      alignment = Alignment.centerRight;
      break;
    case 'bottomLeft':
      alignment = Alignment.bottomLeft;
      break;
    case 'bottomCenter':
      alignment = Alignment.bottomCenter;
      break;
    case 'bottomRight':
      alignment = Alignment.bottomRight;
      break;
  }
  return alignment;
}

const double infinity = 9999999999;

BoxConstraints parseBoxConstraints(Map<String, dynamic>? map) {
  double minWidth = 0.0;
  double maxWidth = double.infinity;
  double minHeight = 0.0;
  double maxHeight = double.infinity;

  if (map != null) {
    if (map.containsKey('minWidth')) {
      var minWidthValue = map['minWidth']?.toDouble();

      if (minWidthValue != null) {
        if (minWidthValue >= infinity) {
          minWidth = double.infinity;
        } else {
          minWidth = minWidthValue;
        }
      }
    }

    if (map.containsKey('maxWidth')) {
      var maxWidthValue = map['maxWidth']?.toDouble();

      if (maxWidthValue != null) {
        if (maxWidthValue >= infinity) {
          maxWidth = double.infinity;
        } else {
          maxWidth = maxWidthValue;
        }
      }
    }

    if (map.containsKey('minHeight')) {
      var minHeightValue = map['minHeight']?.toDouble();

      if (minHeightValue != null) {
        if (minHeightValue >= infinity) {
          minHeight = double.infinity;
        } else {
          minHeight = minHeightValue;
        }
      }
    }

    if (map.containsKey('maxHeight')) {
      var maxHeightValue = map['maxHeight']?.toDouble();

      if (maxHeightValue != null) {
        if (maxHeightValue >= infinity) {
          maxHeight = double.infinity;
        } else {
          maxHeight = maxHeightValue;
        }
      }
    }
  }

  return BoxConstraints(
    minWidth: minWidth,
    maxWidth: maxWidth,
    minHeight: minHeight,
    maxHeight: maxHeight,
  );
}

BoxDecoration parseBoxDecoration(
    Map<String, dynamic>? map, BuildContext context) {
  Color? color;
  DecorationImage? image;
  BorderRadiusGeometry? borderRadius;
  BoxShape? shape;

  if (map != null) {
    if (map.containsKey('themeColor')) {
      color = parseThemeColor(map['themeColor'], context);
    } else if (map.containsKey('color')) {
      color = parseHexColor(map['color']);
    }

    if ((map.containsKey('color') || map.containsKey('themeColor')) &&
        map.containsKey('opacity')) {
      color = color!.withOpacity(double.parse(map['opacity']));
    }

    if (map.containsKey('image')) {
      if (map['image'] is String && (map['image'] as String).isNotEmpty) {
        image = DecorationImage(
            image: NetworkImage(map['image']), fit: parseBoxFit("cover"));
      }
    }

    if (map.containsKey('shape')) {
      switch (map['shape']) {
        case 'circle':
          shape = BoxShape.circle;
        case 'rectangle':
          shape = BoxShape.rectangle;
      }
    }

    if (map.containsKey('borderRadius')) {
      borderRadius = BorderRadius.circular(double.parse(map['borderRadius']));
    }
  }
  if (shape != null) {
    return BoxDecoration(
      color: color,
      image: image,
      borderRadius: borderRadius,
      shape: shape,
    );
  }

  return BoxDecoration(
    color: color,
    image: image,
    borderRadius: borderRadius,
  );
}

extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * SizerUtil.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * SizerUtil.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (SizerUtil.width / 3) / 100;
}

EdgeInsetsGeometry? parseEdgeInsetsGeometry(String? edgeInsetsGeometryString) {
  //left,top,right,bottom
  if (edgeInsetsGeometryString == null ||
      edgeInsetsGeometryString.trim() == '') {
    return null;
  }
  var values = edgeInsetsGeometryString.split(",");
  return EdgeInsets.only(
      left: double.parse(values[0]),
      top: double.parse(values[1]),
      right: double.parse(values[2]),
      bottom: double.parse(values[3]));
}

CrossAxisAlignment parseCrossAxisAlignment(String? crossAxisAlignmentString) {
  switch (crossAxisAlignmentString) {
    case 'start':
      return CrossAxisAlignment.start;
    case 'end':
      return CrossAxisAlignment.end;
    case 'center':
      return CrossAxisAlignment.center;
    case 'stretch':
      return CrossAxisAlignment.stretch;
    case 'baseline':
      return CrossAxisAlignment.baseline;
  }
  return CrossAxisAlignment.center;
}

MainAxisAlignment parseMainAxisAlignment(String? mainAxisAlignmentString) {
  switch (mainAxisAlignmentString) {
    case 'start':
      return MainAxisAlignment.start;
    case 'end':
      return MainAxisAlignment.end;
    case 'center':
      return MainAxisAlignment.center;
    case 'spaceBetween':
      return MainAxisAlignment.spaceBetween;
    case 'spaceAround':
      return MainAxisAlignment.spaceAround;
    case 'spaceEvenly':
      return MainAxisAlignment.spaceEvenly;
  }
  return MainAxisAlignment.start;
}

MainAxisSize parseMainAxisSize(String? mainAxisSizeString) =>
    mainAxisSizeString == 'min' ? MainAxisSize.min : MainAxisSize.max;

TextBaseline parseTextBaseline(String? parseTextBaselineString) =>
    'alphabetic' == parseTextBaselineString
        ? TextBaseline.alphabetic
        : TextBaseline.ideographic;

VerticalDirection parseVerticalDirection(String? verticalDirectionString) =>
    'up' == verticalDirectionString
        ? VerticalDirection.up
        : VerticalDirection.down;

BoxFit? parseBoxFit(String? boxFitString) {
  if (boxFitString == null) {
    return null;
  }

  switch (boxFitString) {
    case 'fill':
      return BoxFit.fill;
    case 'contain':
      return BoxFit.contain;
    case 'cover':
      return BoxFit.cover;
    case 'fitWidth':
      return BoxFit.fitWidth;
    case 'fitHeight':
      return BoxFit.fitHeight;
    case 'none':
      return BoxFit.none;
    case 'scaleDown':
      return BoxFit.scaleDown;
  }

  return null;
}

ImageRepeat? parseImageRepeat(String? imageRepeatString) {
  if (imageRepeatString == null) {
    return null;
  }

  switch (imageRepeatString) {
    case 'repeat':
      return ImageRepeat.repeat;
    case 'repeatX':
      return ImageRepeat.repeatX;
    case 'repeatY':
      return ImageRepeat.repeatY;
    case 'noRepeat':
      return ImageRepeat.noRepeat;

    default:
      return ImageRepeat.noRepeat;
  }
}

Rect? parseRect(String? fromLTRBString) {
  if (fromLTRBString == null) {
    return null;
  }
  var strings = fromLTRBString.split(',');
  return Rect.fromLTRB(double.parse(strings[0]), double.parse(strings[1]),
      double.parse(strings[2]), double.parse(strings[3]));
}

FilterQuality? parseFilterQuality(String? filterQualityString) {
  if (filterQualityString == null) {
    return null;
  }
  switch (filterQualityString) {
    case 'none':
      return FilterQuality.none;
    case 'low':
      return FilterQuality.low;
    case 'medium':
      return FilterQuality.medium;
    case 'high':
      return FilterQuality.high;
    default:
      return FilterQuality.low;
  }
}

String? getLoadMoreUrl(String? url, int currentNo, int? pageSize) {
  if (url == null) {
    return null;
  }

  url = url.trim();
  if (url.contains("?")) {
    url = "$url&startNo=$currentNo&pageSize=$pageSize";
  } else {
    url = "$url?startNo=$currentNo&pageSize=$pageSize";
  }
  return url;
}

StackFit? parseStackFit(String? value) {
  if (value == null) return null;

  switch (value) {
    case 'loose':
      return StackFit.loose;
    case 'expand':
      return StackFit.expand;
    case 'passthrough':
      return StackFit.passthrough;
    default:
      return StackFit.loose;
  }
}

Clip? parseClip(String? value) {
  if (value == null) {
    return null;
  }

  switch (value) {
    case 'none':
      return Clip.none;
    case 'hardEdge':
      return Clip.hardEdge;
    case 'antiAlias':
      return Clip.antiAlias;
    case 'antiAliasWithSaveLayer':
      return Clip.antiAliasWithSaveLayer;
    default:
      return Clip.hardEdge;
  }
}

Map<String, dynamic> parseBannerJson(Map<String, dynamic> map) {
  var bannerMap = jsonDecode(CustomSchemas.bannerJson);
  if (map.isNotEmpty) {
    if (map.containsKey('padding')) {
      bannerMap['padding'] = map['padding'];
    }
    if (map.containsKey('borderRadius')) {
      bannerMap['decoration']['borderRadius'] = map['borderRadius'];
    }
    if (map.containsKey('image')) {
      bannerMap['decoration']['image'] = map['image'];
    }
    if (map.containsKey('header_text')) {
      bannerMap['child']['children'][0]['child']['data'] = map['header_text'];
    }
    if (map.containsKey('footer_text')) {
      bannerMap['child']['children'][1]['child']['data'] = map['footer_text'];
    }
    if (map.containsKey('footer_icon') && map['footer_icon']) {
      bannerMap['child']['children'][1] = {
        "type": "Container",
        "color": "#000000",
        "alignment": "center",
        "width": "46.w",
        "height": "3.h",
        "margin": "0,60,0,0",
        "padding": "2,2,2,2",
        "decoration": {
          "themeColor": "onSurface",
          "borderRadius": "15",
          "opacity": "0.5"
        },
        "child": {
          "type": "Row",
          "mainAxisAlignment": "center",
          "crossAxisAlignment": "center",
          "children": [
            {
              "type": "Text",
              "data": map['footer_text'],
              "maxLines": 3,
              "overflow": "ellipsis",
              "style": {
                "fontSize": "10.s",
                "fontWeight": "w500",
                "themeColor": "onSurfaceVariant",
                "size": 14
              }
            },
            {
              "type": "Icon",
              "data": "arrow_forward",
              "themeColor": "onSurfaceVariant"
            },
          ]
        }
      };
    }
  }
  return bannerMap;
}

Map<String, dynamic> parseHeaderJson(Map<String, dynamic> map) {
  var headerMap = jsonDecode(CustomSchemas.headerJson);
  if (map.isNotEmpty) {
    if (map.containsKey('text')) {
      headerMap['child']['children'][0]['child']['children'][1]['data'] =
          map['text'];
    }
    if (map.containsKey('username')) {
      headerMap['child']['children'][0]['child']['children'][0]['data'] =
          'Hello ${map['username']}';
    }
    if (map.containsKey('profile_image')) {
      headerMap['child']['children'][1]['image'] = map['profile_image'];
    }
  }
  return headerMap;
}

Map<String, dynamic> parseHorizontalList(Map<String, dynamic> map) {
  var circularItemMap = jsonDecode(CustomSchemas.horizontalItemsJson);
  if (map.isNotEmpty) {
    if (map.containsKey('title')) {
      circularItemMap['children'][0]['child']['children'][0]['data'] =
          map['title'];
    }
    if (map.containsKey('widgets')) {
      circularItemMap['children'][1]['child']['children'] = map['widgets'];
    }
  }
  return circularItemMap;
}

double? parseSize(dynamic size) {
  if (size is String) {
    if (size.endsWith('.h')) {
      var height = size.substring(0, size.length - 2);
      return double.parse(height).h;
    }
    if (size.endsWith('.w')) {
      var height = size.substring(0, size.length - 2);
      return double.parse(height).w;
    }
    if (size.endsWith('.s')) {
      var height = size.substring(0, size.length - 2);
      return double.parse(height).sp;
    }
  }
  return null;
}

class SizerUtil {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  ///
  /// This can either be mobile or tablet
  static late DeviceType deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  /// Sets the Screen's size and Device's Orientation,
  /// BoxConstraints, Height, and Width
  static void setScreenSize(
      BoxConstraints constraints, Orientation currentOrientation) {
    // Sets boxconstraints and orientation
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Sets screen width and height
    if (orientation == Orientation.portrait || kIsWeb) {
      width = boxConstraints.maxWidth;
      height = boxConstraints.maxHeight;
    } else {
      width = boxConstraints.maxHeight;
      height = boxConstraints.maxWidth;
    }

    // Sets ScreenType
    if (kIsWeb) {
      deviceType = DeviceType.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      if ((orientation == Orientation.portrait && width < 600) ||
          (orientation == Orientation.landscape && height < 600)) {
        deviceType = DeviceType.mobile;
      } else {
        deviceType = DeviceType.tablet;
      }
    } else if (Platform.isMacOS) {
      deviceType = DeviceType.mac;
    } else if (Platform.isWindows) {
      deviceType = DeviceType.windows;
    } else if (Platform.isLinux) {
      deviceType = DeviceType.linux;
    } else {
      deviceType = DeviceType.fuchsia;
    }
  }

  //for responsive web
  static getWebResponsiveSize({smallSize, mediumSize, largeSize}) {
    return width < 600
        ? smallSize //'phone'
        : width >= 600 && width <= 1024
            ? mediumSize //'tablet'
            : largeSize; //'desktop';
  }
}

/// Type of Device
///
/// This can be either mobile or tablet
enum DeviceType { mobile, tablet, web, mac, windows, linux, fuchsia }
