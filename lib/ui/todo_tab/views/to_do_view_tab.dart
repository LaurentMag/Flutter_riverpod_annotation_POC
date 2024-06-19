import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/states/tab_count_provider.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//  const Tab(icon: Icon(Icons.question_mark_outlined)),

//  const Text("")

class ToDoViewTabs extends ConsumerWidget {
  const ToDoViewTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> tabsHeader = ref.watch(createTabHeaderListProvider);
    List<Widget> tabsContent = ref.watch(tabContentStateProvider);

    return DefaultTabController(
      length: tabsHeader.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              print(tabController.index);
            }
          });

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.grayAppBarBg,
              bottom: TabBar(
                tabs: tabsHeader,
              ),
            ),
            body: Center(
              child: Container(
                color: AppColors.grayLightBg,
                child: TabBarView(
                  children: tabsContent,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class TabContentTesting extends StatelessWidget {
  const TabContentTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.grayLightBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Tab Content 0'),
            Text('Tab Content 1'),
            Text('Tab Content 2'),
            Text('Tab Content 3'),
          ],
        ),
      ),
    );
  }
}
