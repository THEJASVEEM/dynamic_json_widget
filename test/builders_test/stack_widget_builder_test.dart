import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/stack_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = StackWidgetBuild().widgetName;

    expect(type, 'Stack');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Stack'] is StackWidgetBuild,
      true,
    );
  });
}
