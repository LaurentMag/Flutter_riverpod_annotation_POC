import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final clickedGreetingProvider = StateProvider<String?>((ref) => null);

final greetingProvider = Provider.family<String, String>((ref, name) {
  return 'Hello, $name!';
});

final greetingProviderAsFunction = Provider<String Function(String)>((ref) {
  return (String name) => 'Hello, $name!';
});
