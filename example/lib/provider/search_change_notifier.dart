import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class SeacrhChangeNotifier extends ChangeNotifier {
  String jsonString = ''; // Initialize with an empty string

  Map<String, dynamic> mapJson = {}; // Initialize with an empty map

  // JSON string is passed for the [ChangeNotifier]
  void fetchData(String json) {
    jsonString = json;
    mapJson = jsonDecode(json);
    notifyListeners();
  }

  Future<void> searchData(String searchTerm) async {
    var map = jsonDecode(jsonString);
    searchMapForString(map, searchTerm);
    notifyListeners();
  }

  ///[searchMapForString] is a outerFunction which calls a recursive inner
  ///function `search` for searching the term recursively through the map
  ///
  ///The result is set of widgets which has a text as the search term.

  void searchMapForString(Map<String, dynamic> map, String searchString) {
    List<Map<String, dynamic>> matches = [];
    var listParent = {};

    if (searchString.isEmpty) {
      resetSearch();
      return;
    }

    void search(Map<String, dynamic> currentMap) {
      currentMap.forEach((key, value) {
        if (value is String && !value.contains('http')) {
          if (value.toLowerCase().contains(searchString.toLowerCase())) {
            if (listParent.isNotEmpty) {
              if (listParent.containsKey('widgets')) {
                if (listParent['type'] == 'Carousel') {
                  log('Carousel found');
                  matches.add(currentMap);
                } else {
                  listParent['widgets'] = [currentMap];
                  matches.add(listParent as Map<String, dynamic>);
                }
              }
            }
          }
        } else if (value is Map<String, dynamic>) {
          search(value);
        } else if (value is List) {
          listParent = currentMap;
          for (var element in value) {
            search(element);
          }
        }
      });
    }

    search(map);

    Map<String, dynamic> searchField = mapJson['children'][1];
    searchField['child']['searchTerm'] = searchString;
    Map<String, dynamic> copyWith = Map.from(mapJson);

    if (matches.isEmpty) {
      copyWith['children'] = [
        mapJson['children'][0],
        searchField,
        {
          "type": "Center",
          "child": {
            "type": "Text",
            "data": "Could not find matching result",
            "maxLines": 3,
            "overflow": "ellipsis",
            "style": {"fontSize": "10.s", "size": 2}
          }
        }
      ];
    } else {
      copyWith['children'] = [
        mapJson['children'][0],
        searchField,
        ...matches,
      ];
    }

    mapJson = copyWith;
    return;
  }

  void resetSearch() {
    mapJson = jsonDecode(jsonString);
    notifyListeners();
  }
}
