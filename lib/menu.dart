import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/states/todo_provider.dart';
import 'package:flutter_new_riverpod_test/ui/general/navigation_button.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Menu extends ConsumerStatefulWidget {
  const Menu({super.key});

  @override
  ConsumerState<Menu> createState() => _MenuState();
}

class _MenuState extends ConsumerState<Menu> {
  @override
  void initState() {
    super.initState();
    ref.read(toDoStateProvider.notifier).retrieveToDos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grayAppBarBg,
        title: const Text(
          'Menu',
          style: TextStyle(color: AppColors.grayDark),
        ),
      ),
      backgroundColor: AppColors.grayLightBg,
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
            NavigationButton(
              buttonText: 'todo list',
              action: () => context.go('/todo_list'),
            ),
            NavigationButton(
              buttonText: 'todo list with tabs',
              action: () => context.go('/todo_list_tabs'),
            ),
            NavigationButton(
              buttonText: 'animation controller test',
              action: () => context.go('/animation_controller_test'),
            ),
          ],
        ),
      ),
    );
  }
}
