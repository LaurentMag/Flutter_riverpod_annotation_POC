import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/animation_controller/card_translation_testing.dart';
import 'package:flutter_new_riverpod_test/ui/counter_quote_test/counter_quote_test.dart';
import 'package:flutter_new_riverpod_test/menu.dart';
import 'package:flutter_new_riverpod_test/ui/todo/views/to_do_view.dart';
import 'package:flutter_new_riverpod_test/ui/todo_tab/views/to_do_view_tab.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Menu();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'counter_quote',
          builder: (BuildContext context, GoRouterState state) {
            return const CounterQuoteTest();
          },
        ),
        GoRoute(
          path: 'animation_controller_test',
          builder: (BuildContext context, GoRouterState state) {
            return const CardTranslationTesting();
          },
        ),
        GoRoute(
          path: 'todo_list',
          builder: (BuildContext context, GoRouterState state) {
            return const ToDoView();
          },
        ),
        GoRoute(
          path: 'todo_list_tabs',
          builder: (BuildContext context, GoRouterState state) {
            return const ToDoViewTabs();
          },
        ),
      ],
    ),
  ],
);
