import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_dynamic_widgets/src/builders/circular_avatar_widget_builder.dart';
import 'package:nymble_dynamic_widgets/widget_builder.dart';

void main() {
  test('type', () {
    var type = CircularAvatarWidgetBuilder().widgetName;

    expect(type, 'CircularAvatar');
    DynamicWidgetBuilder.initDefault();
    expect(
      DynamicWidgetBuilder.widgetNameParserMap['CircularAvatar']
          is CircularAvatarWidgetBuilder,
      true,
    );
  });
}
