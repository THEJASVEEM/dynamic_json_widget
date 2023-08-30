<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Dynamic JSON Widget Builder

Say Hi to better rendering engine from JSON. Load any widget to your app without the need of updating.

## Features
1. Framework Creation: I have built a custom rendering engine framework that can dynamically render widgets based on JSON data without relying on     external packages like json_dynamic_widget.
2. User Interface: I have implemented an attractive user interface that supports both light and dark themes. The UI is designed to showcase the capabilities of the rendering engine with various widget types.
Widget Customization: The rendering engine allows customization of each widget's properties through the JSON data, including text, images, colors, and more.
3. Multiple Widget Types: I have implemented three core widget types: Banner, Horizontal List, and Banner Carousel. Each widget type supports dynamic customization and validation.
4. Search Field: I have implemented the search field that actually searches a list of text.
Handle Click Listener: Can tap on the banner widgets in the carousel to check the click listener.
5. Yes the app supports handling of theme from the JSON
6. Multiple Screens: As mentioned above if tapped on the banner it takes you to the detail recipe page to demonstrate multiple screens.
7. Unit Tests: I have included comprehensive unit tests that cover different scenarios, ensuring the reliability and correctness of the rendering engine.
8. Widget Tests: I have written widget tests to validate the rendering of individual widgets and their behavior.

## Getting started

### Installation

Make sure your environment is setup to work with flutter and then to get started with the developmet of this project, clone and run the following.
    
```sh
flutter pub get
```

We use Monarch for our testing, so be sure to install that. You can follow the docs [here.](https://monarchapp.io/docs/install)

## Usage

Run `flutter run` from the `example` folder to run on a connected device

```sh
cd example
flutter run
```

For regular tests you can use

```sh
cd example
flutter test
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

