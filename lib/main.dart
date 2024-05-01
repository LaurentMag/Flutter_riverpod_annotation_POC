import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: AppRoot(),
  ));
}
