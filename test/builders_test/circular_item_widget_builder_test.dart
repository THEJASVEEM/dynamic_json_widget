import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/circular_item_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = CircularItemWidgetBuilder().widgetName;

    expect(type, 'CircularItem');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['CircularItem']
          is CircularItemWidgetBuilder,
      true,
    );
  });
}
