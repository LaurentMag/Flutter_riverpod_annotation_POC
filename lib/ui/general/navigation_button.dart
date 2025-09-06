import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui_style/component_style.dart';

class NavigationButton extends StatelessWidget {
  final String buttonText;
  final Function action;

  const NavigationButton({
    super.key,
    required this.buttonText,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              action();
            },
            style: ElevatedButtonStyle.navigationButtonStyle,
            child: Text(buttonText)),
      ),
    );
  }
}
