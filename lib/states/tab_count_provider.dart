import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/tab_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_count_provider.g.dart';

/// Handle the index of the selected tab
@Riverpod(keepAlive: true)
class TabIndexState extends _$TabIndexState {
  @override
  int build() {
    return 0;
  }

  setIndex(int index) {
    state = index;
  }

  getIndex() {
    return state;
  }
}

/// Handle the list of tab headers
@Riverpod(keepAlive: true)
class TabHeaderListState extends _$TabHeaderListState {
  @override
  List<TabHeader> build() {
    return [
      const TabHeader(icon: Icons.format_list_bulleted_rounded, text: "All"),
      const TabHeader(icon: Icons.av_timer_rounded, text: "running"),
      const TabHeader(icon: Icons.checklist_rounded, text: "completed"),
    ];
  }
}

/// Create the list of tab headers
/// watch the tabHeaderListStateProvider to create the list when it changes
@Riverpod(keepAlive: true)
List<Widget> createTabHeaderList(CreateTabHeaderListRef ref) {
  List<TabHeader> tabDataList = ref.watch(tabHeaderListStateProvider);

  return tabDataList.map((TabHeader tab) => tab.createTab).toList();
}

/// Handle the list of tab content
@Riverpod(keepAlive: true)
class TabContentState extends _$TabContentState {
  @override
  List<Widget> build() {
    return [
      const Icon(Icons.directions_car),
      const Icon(Icons.directions_transit),
      const Icon(Icons.directions_bike),
    ];
  }
}
