import 'package:flutter/material.dart';

class ErrorPlaceholderWidget extends StatelessWidget {
  const ErrorPlaceholderWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return _buildErrorWidget(message, context);
  }

  Widget _buildErrorWidget(String message, BuildContext buildContext) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Placeholder(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.only(left: 15, right: 15),
          height: 150,
          child: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(buildContext).colorScheme.error),
            ),
          ),
        ),
      ),
    );
  }
}
