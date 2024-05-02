import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/router/router.dart';
import 'package:flutter_new_riverpod_test/ui/visual_settings/colors.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
