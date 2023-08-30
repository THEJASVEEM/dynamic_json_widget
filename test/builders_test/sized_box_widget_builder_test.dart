import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/sized_box_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = SizedBoxWidgetBuild().widgetName;

    expect(type, 'SizedBox');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['SizedBox']
          is SizedBoxWidgetBuild,
      true,
    );
  });
}
