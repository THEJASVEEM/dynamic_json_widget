import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/row_column_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = RowWidgetBuilder().widgetName;

    expect(type, 'Row');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Row'] is RowWidgetBuilder,
      true,
    );

    type = ColumnWidgetBuilder().widgetName;

    expect(type, 'Column');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Column'] is ColumnWidgetBuilder,
      true,
    );
  });
}
