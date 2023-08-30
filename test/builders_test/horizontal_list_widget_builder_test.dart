import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/horizontal_list_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = HorizontalListWidgetBuilder().widgetName;

    expect(type, 'Horizontal_Lists');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Horizontal_Lists']
          is HorizontalListWidgetBuilder,
      true,
    );
  });
}
