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
    List<Widget> tabsHeaders = ref.watch(setTabHeaderWidgetsProvider);
    List<Widget> tabsContent = ref.watch(tabContentStateProvider);
    final int tabControllerLength = tabsHeaders.length;

    return DefaultTabController(
      length: tabControllerLength,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(
            () {
              if (!tabController.indexIsChanging) {
                setTabIndex(ref: ref, index: tabController.index);
              }
            },
          );

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.grayAppBarBg,
              bottom: TabBar(
                tabs: tabsHeaders,
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
                  onPressed: () => createTab(ref: ref),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: const Text('removeButton'),
                  onPressed: () => removeCurrentTab(ref: ref),
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

void createTab({required WidgetRef ref}) {
  ref.read(tabHeaderStateProvider.notifier).addTab();
  ref.read(tabContentStateProvider.notifier).addTab();
}

void removeCurrentTab({required WidgetRef ref}) {
  int currentIndex = ref.read(tabIndexStateProvider);
  ref.read(tabHeaderStateProvider.notifier).removeTab(currentIndex);
  ref.read(tabContentStateProvider.notifier).removeTab(currentIndex);
}

void setTabIndex({required WidgetRef ref, required int index}) {
  ref.read(tabIndexStateProvider.notifier).setIndex(index);
}

// --------------------------------------------------------------------------------------------
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
