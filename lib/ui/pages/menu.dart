import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/components/navigation_button.dart';
import 'package:flutter_new_riverpod_test/ui/visual_settings/colors.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text(
          'Menu',
          style: TextStyle(color: AppColors.textColor),
        ),
      ),
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            NavigationButton(
              buttonText: 'counter quote',
              action: () => context.go('/counter_quote'),
            ),
            const SizedBox(height: 32),
            NavigationButton(
              buttonText: 'todo list',
              action: () => context.go('/todo_list'),
            ),
          ],
        ),
      ),
    );
  }
}
