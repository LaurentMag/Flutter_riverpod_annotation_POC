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
    final int tabControllerLenght = tabsHeader.length;

    print("In the widget : ${tabsHeader.length}");

    void createTab() {
      ref.read(tabHeaderListStateProvider.notifier).addTab();
      ref.read(tabContentStateProvider.notifier).addTab();
    }

    void removeCurentTab() {
      int currentIndex = ref.read(tabIndexStateProvider);
      ref.read(tabHeaderListStateProvider.notifier).removeTab(currentIndex);
      ref.read(tabContentStateProvider.notifier).removeTab(currentIndex);
    }

    void setTabIndex(index) {
      ref.read(tabIndexStateProvider.notifier).setIndex(index);
    }

    return DefaultTabController(
      length: tabControllerLenght,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              setTabIndex(tabController.index);
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
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: const Text('addButton'),
                  onPressed: createTab,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: const Text('removeButton'),
                  onPressed: removeCurentTab,
                  child: const Icon(Icons.remove),
                ),
              ],
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
