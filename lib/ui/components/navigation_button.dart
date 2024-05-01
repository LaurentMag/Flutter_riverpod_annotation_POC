import 'package:flutter/material.dart';

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
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          // Navigator.of(context).pushNamed(redirectionPath);
          action();
        },
        child: Text(buttonText),
      ),
    );
  }
}
