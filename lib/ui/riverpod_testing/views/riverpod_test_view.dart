import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/states/provider_no_auto_generated_code.dart';
import 'package:flutter_new_riverpod_test/ui/general/app_bar_go_back.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverpodTestView extends ConsumerWidget {
  const RiverpodTestView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clickedValueController = ref.read(clickedGreetingProvider.notifier);
    final greetingController = ref.read(greetingProviderAsFunction);

    final clickedValue = ref.watch(clickedGreetingProvider);

    return Scaffold(
      backgroundColor: AppColors.grayLightBg,
      appBar: const AppBarGoBack(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Riverpod Testing View',
              ),
              SizedBox(height: 60),
              Text(
                'Click value : ${clickedValue ?? "No Value"}',
              ),
              SizedBox(height: 20),
              PageButton(
                label: 'Display value',
                backgroundColor: Colors.blue,
                onPressed: () {
                  // final newGreeting = ref.read(greetingProvider('Bob from family'));
                  final greeting = greetingController(DateTime.now().toString());
                  clickedValueController.state = greeting;
                },
              ),
              SizedBox(height: 10),
              PageButton(
                label: 'Reset Value',
                backgroundColor: const Color.fromARGB(255, 244, 158, 54),
                onPressed: () {
                  clickedValueController.state = null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageButton extends ConsumerWidget {
  final String label;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const PageButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
