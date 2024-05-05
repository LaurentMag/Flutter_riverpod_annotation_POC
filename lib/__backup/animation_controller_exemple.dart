import 'package:flutter/material.dart';

/*
Sure, here is a simple example of AnimationController in Flutter. 
This example creates an AnimationController and a Tween to animate the opacity 
of a Container from 0 to 1 over a duration of 3 seconds.


In this example, `FadeInDemo` is a `StatefulWidget` that creates an `AnimationController` 
in its `initState` method. The `AnimationController` controls a `Tween` 
that interpolates between 0 and 1. The `FadeTransition` widget uses the `AnimationController` 
to control the opacity of a `Container`. The `AnimationController` 
is started by calling `forward` and it animates the `Container`'s opacity from 0 to 1 over 3 seconds.
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: FadeInDemo(),
        ),
      ),
    );
  }
}

class FadeInDemo extends StatefulWidget {
  const FadeInDemo({super.key});

  @override
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 1).animate(controller!);

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation!,
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
