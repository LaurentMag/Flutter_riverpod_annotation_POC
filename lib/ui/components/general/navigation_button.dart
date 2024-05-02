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
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            // Navigator.of(context).pushNamed(redirectionPath);
            action();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: const Color.fromARGB(255, 226, 223, 223),
            backgroundColor: const Color.fromARGB(255, 53, 54, 55),
            elevation: 5,
          ),
          child: Text(buttonText)),
    );
  }
}
