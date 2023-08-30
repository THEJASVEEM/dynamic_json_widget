import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

class ListViewWidgetBuilder extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }

    var reverse = map.containsKey("reverse") ? map['reverse'] : false;
    var shrinkWrap = map.containsKey("shrinkWrap") ? map["shrinkWrap"] : false;
    var cacheExtent =
        map.containsKey("cacheExtent") ? map["cacheExtent"]?.toDouble() : 0.0;
    var padding = map.containsKey('padding')
        ? parseEdgeInsetsGeometry(map['padding'])
        : null;
    var itemExtent =
        map.containsKey("itemExtent") ? map["itemExtent"]?.toDouble() : null;
    var children = DynamicWidgetBuilder.buildWidgets(
      map['children'],
      buildContext,
      listener,
      streamController,
    );
    var pageSize = map.containsKey("pageSize") ? map["pageSize"] : 10;
    var loadMoreUrl =
        map.containsKey("loadMoreUrl") ? map["loadMoreUrl"] : null;
    var isDemo = map.containsKey("isDemo") ? map["isDemo"] : false;

    var params = ListViewParams(
        scrollDirection: scrollDirection,
        reverse: reverse,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        padding: padding,
        itemExtent: itemExtent,
        children: children,
        pageSize: pageSize,
        loadMoreUrl: loadMoreUrl,
        isDemo: isDemo);

    return ListViewWidget(
      params: params,
      buildContext: buildContext,
    );
  }

  @override
  String get widgetName => "ListView";

  @override
  Type get widgetType => ListViewWidget;
}

class ListViewWidget extends StatefulWidget {
  final ListViewParams params;
  final BuildContext buildContext;

  const ListViewWidget(
      {required this.params, required this.buildContext, super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  ListViewParams _params = ListViewParams();
  final List<Widget?> _items = [];

  final ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;

  //If there are no more items, it should not try to load more data while scroll
  //to bottom.
  bool loadCompleted = false;

  // _ListViewWidgetState(this._params) {
  //   if (_params.children != null) {
  //     _items.addAll(_params.children!);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _params = widget.params;
    if (_params.children != null) {
      _items.addAll(_params.children!);
    }
    if (_params.loadMoreUrl == null || _params.loadMoreUrl!.isEmpty) {
      loadCompleted = true;
      return;
    }
    _scrollController.addListener(() {
      if (!loadCompleted &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {}
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: _params.scrollDirection ?? Axis.vertical,
      reverse: _params.reverse ?? false,
      shrinkWrap: _params.shrinkWrap ?? false,
      cacheExtent: _params.cacheExtent,
      padding: _params.padding,
      itemCount: loadCompleted ? _items.length : _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildProgressIndicator();
        } else {
          return _items[index]!;
        }
      },
      controller: _scrollController,
    );
  }
}

class ListViewParams {
  Axis? scrollDirection;
  bool? reverse;
  bool? shrinkWrap;
  double? cacheExtent;
  EdgeInsetsGeometry? padding;
  double? itemExtent;
  List<Widget?>? children;

  /// use to data binding
  String? dataKey;

  /// use to data binding
  Widget? tempChild;

  int? pageSize;
  String? loadMoreUrl;

  //use for demo, if true, it will do the fake request.
  bool? isDemo;

  ListViewParams(
      {this.scrollDirection,
      this.reverse,
      this.shrinkWrap,
      this.cacheExtent,
      this.padding,
      this.itemExtent,
      this.children,
      this.pageSize,
      this.loadMoreUrl,
      this.isDemo,
      this.tempChild,
      this.dataKey}) {
    // assert(this.children != null || this.tempChild != null,
    //     "you must set one of [children] or [tempChild]");
    // if (this.tempChild != null) {
    //   assert(this.dataKey != null && this.children == null,
    //       "you must set [dataKey] and [children] not to set");
    // }
    // if (this.children != null) {
    //   assert(this.dataKey == null && this.tempChild == null,
    //       "do not set any dataKey and tempChild");
    // }
  }
}
