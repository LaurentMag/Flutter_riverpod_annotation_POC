import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/states/counter_provider.dart';
import 'package:flutter_new_riverpod_test/states/test_provider.dart';
import 'package:flutter_new_riverpod_test/ui/components/general/app_bar_go_back.dart';
import 'package:flutter_new_riverpod_test/ui/visual_settings/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterQuoteTest extends ConsumerWidget {
  const CounterQuoteTest({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countervalue = ref.watch(counterStateProvider);
    final randomQuote = ref.watch(randomQuoteProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLightColor,
      appBar: const AppBarGoBack(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Counter Value from provider:',
              ),
              Text(
                '$countervalue',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 64),
              const Text(
                'Random Quote:',
              ),
              Text(
                randomQuote,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () => incrementCounter(ref),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () => decrementCounter(ref),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 64),
            FloatingActionButton(
              heroTag: "btn3",
              onPressed: () => getRandomQuote(ref),
              tooltip: 'display random quote',
              child: const Icon(Icons.replay),
            ),
          ],
        ),
      ),
    );
  }
}

void incrementCounter(WidgetRef ref) {
  ref.read(counterStateProvider.notifier).increment();
}

void decrementCounter(WidgetRef ref) {
  ref.read(counterStateProvider.notifier).decrement();
}

void getRandomQuote(WidgetRef ref) {
  ref.invalidate(randomQuoteProvider);
}
