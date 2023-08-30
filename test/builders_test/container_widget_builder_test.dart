import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/container_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = ContainerWidgetBuilder().widgetName;

    expect(type, 'Container');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['Container']
          is ContainerWidgetBuilder,
      true,
    );
  });
}
