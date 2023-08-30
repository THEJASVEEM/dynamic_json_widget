import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class SearchWidgetBuilder extends WidgetParser {
  Timer? _debounceTimer;
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    bool focus = false;
    if (map.containsKey('searchTerm')) {
      focus = true;
    }
    return TextFormField(
      key: Key(map['key']),
      initialValue: map['searchTerm'] ?? '',
      autofocus: focus,
      cursorHeight: 16,
      onChanged: (value) {
        _debounceTimer?.cancel();
        if (value.isEmpty) {
          map['searchTerm'] = '';
        }
        // Start a new timer to perform an action after a delay
        _debounceTimer = Timer(const Duration(milliseconds: 500), () {
          // Perform your action here, for example updating the UI or making a request
          log(value);
          if (value.length >= 5 || value.isEmpty) {
            streamController.add(MapEntry(Key(map['key']), value));
          }
        });
      },
      decoration: InputDecoration(
        hintText: 'Search any recipes',
        hintStyle: const TextStyle(
          color: Color(0xFF8D8D8D),
        ),

        filled: true,
        fillColor: parseThemeColor('onBackground', buildContext),
        // contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(31),
        ),
        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF8D8D8D)),
        isDense: true,
      ),
    );
  }

  // @override
  // void dispose() {
  //   log('disposed');
  //   _debounceTimer?.cancel();
  //   super.dispose();
  // }

  @override
  String get widgetName => 'Search';

  @override
  Type get widgetType => SearchWidgetBuilder;
}
