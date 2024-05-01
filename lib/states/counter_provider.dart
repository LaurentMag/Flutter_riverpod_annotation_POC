import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

@riverpod
class CounterState extends _$CounterState {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;
}
