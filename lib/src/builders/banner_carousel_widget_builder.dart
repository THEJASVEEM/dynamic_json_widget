import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/src/components/placeholder_widget.dart';
import 'package:nymble_dynamic_widgets/src/components/utils.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_parser.dart';

/// Widget parser for `BannerCarousel` widget.
class BannerCarouselWidgetBuilder extends WidgetParser {
  String? errorMessage = '';
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
    StreamController streamController,
  ) {
    var scrollDirection = Axis.vertical;
    var reverse = false;
    var shrinkWrap = false;
    var children = DynamicWidgetBuilder.buildWidgets(
        map['widgets'], buildContext, listener, streamController);
    var pageSize = map.containsKey("pageSize") ? map["pageSize"] : 10;
    var title = map.containsKey('title') ? map['title'] : 'Recommendation';

    var params = PageViewParams(
      scrollDirection: scrollDirection,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      children: children,
      pageSize: pageSize,
    );

    ///Based on whether widgets or children widget pass the
    ///validation render error [ErrorPlaceholderWidget] widget or render
    ///carousel widget
    if (!validateWidgets(map, buildContext)) {
      return ErrorPlaceholderWidget(message: errorMessage!);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(buildContext).colorScheme.onSurface),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(buildContext).colorScheme.primary),
                )
              ],
            ),
          ),
          PageViewWidget(
            params: params,
            buildContext: buildContext,
          ),
        ],
      );
    }
  }

  ///Validate the children widgets based on
  ///1. All the children widgets are of the type [Banner]
  ///2. Whether there are atleat 2 widgets
  bool validateWidgets(Map<String, dynamic> map, BuildContext buildContext) {
    for (var widget in map['widgets']) {
      if (widget['type'] != 'Banner') {
        errorMessage =
            'The widgets in Banner Carousel must be only Banner type widget';
        return false;
      }
    }
    if ((map['widgets'] as List).length < 2) {
      errorMessage =
          'The Banner Carousel widget must contain 2 or more banenrs';
      return false;
    }
    return true;
  }

  @override
  String get widgetName => "Carousel";

  @override
  Type get widgetType => PageViewWidget;
}

/// [PageView] is used for smooth carousel
/// takes parameters from the map with the help of [PageViewParams]
class PageViewWidget extends StatefulWidget {
  final PageViewParams params;
  final BuildContext buildContext;

  const PageViewWidget(
      {required this.params, required this.buildContext, super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  PageViewParams _params = PageViewParams();
  final List<Widget?> _items = [];

  final PageController _pageController = PageController();
  final int _numPages = 3; // Number of pages in the carousel
  int _currentPage = 0;
  double _indicatorOffset = 0.0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _params = widget.params;
    if (_params.children != null) {
      _items.addAll(_params.children!);
    }
  }

  ///A helper function to animate to the next page every 5 seconds
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 26.h,
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          SizedBox(
            height: 22.h,
            child: PageView.builder(
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                overscroll: false,
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                  _indicatorOffset = page.toDouble();
                });
              },
              scrollDirection: Axis.horizontal,
              reverse: _params.reverse ?? false,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _items[index]!;
              },
              controller: _pageController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildAnimatedPageIndicator(),
        ],
      ),
    );
  }

  /// Function to render the carousel indicator
  Widget _buildAnimatedPageIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _numPages,
          (index) {
            return Container(
              width: _indicatorOffset == index ? 10 : 6,
              height: _indicatorOffset == index ? 10 : 6,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _indicatorOffset == index
                    ? parseThemeColor('primary', context)
                    : Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}

///Used to get values from the JSON for [PageViewWidget]
class PageViewParams {
  Axis? scrollDirection;
  bool? reverse;
  bool? shrinkWrap;
  double? cacheExtent;
  EdgeInsetsGeometry? padding;
  double? itemExtent;
  List<Widget?>? children;

  String? dataKey;

  Widget? tempChild;

  int? pageSize;
  String? loadMoreUrl;

  bool? isDemo;

  PageViewParams(
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
      this.dataKey});
}
