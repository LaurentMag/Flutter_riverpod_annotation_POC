import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToDoViewTabs extends ConsumerWidget {
  const ToDoViewTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.grayAppBarBg,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.format_list_bulleted_rounded)),
              Tab(icon: Icon(Icons.av_timer_rounded)),
              Tab(icon: Icon(Icons.checklist_rounded)),
            ],
          ),
        ),
        body: Center(
          child: Container(
            color: AppColors.grayLightBg,
            child: const TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
        Icon(Icons.directions_car),
        Icon(Icons.directions_transit),
        Icon(Icons.directions_bike),
*/