import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/tab_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tab_count_provider.g.dart';

@Riverpod(keepAlive: true)
class TabCountState extends _$TabCountState {
  @override
  int build() => 3;

  void addTab() => state++;
}

List<int> createArray(int length) {
  return List<int>.generate(length, (int index) => index);
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

// -------------------------------------------------------


