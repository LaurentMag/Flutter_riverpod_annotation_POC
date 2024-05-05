import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/router.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.grayLightBg),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
