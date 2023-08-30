import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/banner_carousel_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = BannerCarouselWidgetBuilder().widgetName;

    expect(type, 'Carousel');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Carousel']
          is BannerCarouselWidgetBuilder,
      true,
    );
  });
}
