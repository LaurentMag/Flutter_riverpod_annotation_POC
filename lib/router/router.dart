import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui/pages/counter_quote_test.dart';
import 'package:flutter_new_riverpod_test/ui/pages/menu.dart';
import 'package:flutter_new_riverpod_test/ui/pages/to_do_list.dart';
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
          path: 'todo_list',
          builder: (BuildContext context, GoRouterState state) {
            return ToDoList();
          },
        ),
      ],
    ),
  ],
);
