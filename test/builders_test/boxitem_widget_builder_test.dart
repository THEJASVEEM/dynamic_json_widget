import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/box_item_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = BoxItemWidgetBuilder().widgetName;

    expect(type, 'BoxItem');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['BoxItem']
          is BoxItemWidgetBuilder,
      true,
    );
  });
}
