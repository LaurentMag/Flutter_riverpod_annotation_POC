import 'package:flutter/material.dart';

const double height = 100;
const double rightTranslationPercentageLimit = 0.7;
const double buttonFullWidthThreshold = 0.60;

const double defaultButtonWidth = 80;

const Color colorblue = Color.fromARGB(255, 33, 115, 197);

const int buttonAnimDuration = 110;

const colorFixedBackground = Color.fromARGB(255, 255, 255, 255);

// ------------------------------------------------------------------------------------------
class CardTranslationTesting extends StatefulWidget {
  const CardTranslationTesting({super.key});

  @override
  State<CardTranslationTesting> createState() => _CardTranslationTestingState();
}

class _CardTranslationTestingState extends State<CardTranslationTesting> {
  // TRANSLATION STATE
  double translationX = 0.0;

  /// stop the translationX to not go over the rightTranslationPercentageLimit
  /// (cardWidth * 0.7 = translation value to not exceed)
  /// the moveValue > 0 ensure that it will stop only when the user is trying to move the card to the right, allowing to move it back to the left
  void updateTranslationX(double value, double cardWidth, double moveValue) {
    if (translationX.abs() >= cardWidth * rightTranslationPercentageLimit &&
        moveValue > 0) {
      return;
    }
    setState(() {
      translationX += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // CARDWIDTH
    double cardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            double moveValue = details.delta.dx;
            updateTranslationX(moveValue, cardWidth, moveValue);
          },
          child: Stack(
            children: [
              FixedBackground(
                translationX: translationX,
                cardWidth: cardWidth,
              ),
              HorizontalAnimation(
                translationX: translationX,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------
class FixedBackground extends StatelessWidget {
  final double translationX;
  final double cardWidth;

  const FixedBackground({
    super.key,
    required this.translationX,
    required this.cardWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          color: colorFixedBackground,
        ),
        Row(
          children: [
            // PLACEHOLDER for width
            AnimatedContainer(
              duration: const Duration(milliseconds: buttonAnimDuration),
              height: height,
              width: setButtonWidth(translationX),
              decoration: buttonDecoration(Colors.transparent),
            ),
            // BUTTON
            AnimatedContainer(
              duration: const Duration(milliseconds: buttonAnimDuration),
              height: height,
              width: setButtonWidth(translationX),
              decoration:
                  buttonDecoration(const Color.fromARGB(255, 99, 152, 26)),
              child: const Center(
                child: Icon(Icons.edit_outlined),
              ),
            ),
          ],
        ),
        // BUTTON Upper layer
        AnimatedContainer(
          duration: const Duration(milliseconds: buttonAnimDuration),
          height: height,
          width: setDynamicButtonWidth(translationX, cardWidth),
          decoration: buttonDecoration(const Color.fromARGB(255, 210, 100, 17)),
          child: const Center(
            child: Icon(Icons.delete_outline),
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------------------------------------
class HorizontalAnimation extends StatelessWidget {
  final double translationX;

  const HorizontalAnimation({
    super.key,
    required this.translationX,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: buttonAnimDuration),
      transform: Matrix4.translationValues(translationX, 0, 0),
      child: const MovingCard(),
    );
  }
}

// ------------------------------------------------------------------------------------------
class MovingCard extends StatelessWidget {
  const MovingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 8, 79, 126),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          '- Drag me -',
          style: TextStyle(
            color: Color.fromARGB(255, 232, 230, 225),
          ),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------

/// Determine the buttin width.
/// If the translationX is less than the defaultButtonWidth, return the defaultButtonWidth
/// else return the half of the translationX
///
/// (as there is 2 buttons to display occupying equalty the translation space between the border and the card left border)
double setButtonWidth(double translationX) {
  final double halfTranslation = translationX / 2;

  return halfTranslation < defaultButtonWidth
      ? defaultButtonWidth
      : halfTranslation;
}

/// Determine the dynamic button width, able to take the full translationX as width.
/// - If the translationX is greater than the rightTranslationPercentageLimit : return the translationX as width
/// - else return the half of the translationX
/// - If the dynamicButtonWidth is less than the defaultButtonWidth, return the defaultButtonWidth to keep a default button size
double setDynamicButtonWidth(double translationX, double cardWidth) {
  final double halfTranslation = translationX / 2;
  // if the translationX is greater than the rightTranslationPercentageLimit
  final bool isTranslationXExceedingThreshold =
      translationX > cardWidth * rightTranslationPercentageLimit;

  // if translation greater than the threshold, return the translationX as width, else return the half of the translationX like others buttons
  final double dynamicButtonWidth =
      isTranslationXExceedingThreshold ? translationX : halfTranslation;

  // check if the translation is lesser than the defaultButtonWidth
  final bool isTranslationLessThanDefaultButtonWidth =
      halfTranslation < defaultButtonWidth;

  return isTranslationLessThanDefaultButtonWidth
      ? defaultButtonWidth
      : dynamicButtonWidth;
}

// ------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------

BoxDecoration buttonDecoration(Color bgColor) {
  return BoxDecoration(
    color: bgColor,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: colorFixedBackground,
      width: 2,
    ),
  );
}
