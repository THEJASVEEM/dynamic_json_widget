import 'package:example/homepage_builder.dart';
import 'package:example/pages/recipe.dart';
import 'package:flutter/material.dart';
import 'package:nymble_dynamic_widgets/sizer.dart';

///[MaterialWidget] is used to get the theme from
///the JSON and initialize the themeMode dynmically

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({super.key, required this.json, required this.theme});

  final String json;
  final String theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: theme == 'light' ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2EA270),
          primary: const Color(0xFF2EA270),
          background: const Color(0xFFF6F6F6),
          primaryContainer: const Color(0xFFFFFFFF),
          onBackground: const Color(0xFFFFFFFF),
          secondaryContainer: const Color(0xFFFFFFFF),
          onSurface: const Color(0xFF000000),
          onSurfaceVariant: const Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2EA270),
          primary: const Color(0xFF2EA270),
          background: const Color(0xFF2A2A2A),
          primaryContainer: const Color(0xFFFFFFFF),
          onBackground: const Color(0xFF353535),
          secondaryContainer: const Color(0xFF3A3A3A),
          onSurface: const Color(0xFFFFFFFF),
          onSurfaceVariant: const Color(0xFF000000),
        ),
        useMaterial3: true,
      ),
      routes: {
        '/recipe': (context) => const Recipe(),
      },
      home: Sizer(builder: (context, orientation, deviceType) {
        return HomePageBuilder(
          jsonString: json,
        );
      }),
    );
  }
}
