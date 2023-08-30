// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:example/homepage_builder.dart';
import 'package:example/material_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Test for HomePage & Material Widget',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomePageBuilder), findsOneWidget);
      expect(find.byType(MaterialWidget), findsOneWidget);
    });
  });
  testWidgets('Test for Search Widget', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final textFieldFinder = find.byType(TextFormField);
      await tester.enterText(textFieldFinder, 'vegan');

      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(find.text('Vegan'), findsAtLeastNWidgets(2));
    });
  });
  testWidgets('Test for Tapping Banner', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      final pageViewFinder = find.byType(PageView);
      await tester.tap(pageViewFinder);

      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      expect(find.text('Lasagna'), findsAtLeastNWidgets(1));
    });
  });
}
