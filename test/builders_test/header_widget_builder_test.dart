import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/header_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = HeaderWidgetBuilder().widgetName;

    expect(type, 'Header');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Header'] is HeaderWidgetBuilder,
      true,
    );
  });
}
