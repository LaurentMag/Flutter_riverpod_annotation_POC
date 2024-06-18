// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tabCountStateHash() => r'a8282a663cffd306d196278bb16eb21f6163a6af';

/// See also [TabCountState].
@ProviderFor(TabCountState)
final tabCountStateProvider = NotifierProvider<TabCountState, int>.internal(
  TabCountState.new,
  name: r'tabCountStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabCountStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabCountState = Notifier<int>;
String _$tabHeaderListStateHash() =>
    r'19c24d5fd65fcc57f26a1fa8b052d74b19d91281';

/// Handle the list of tab headers
///
/// Copied from [TabHeaderListState].
@ProviderFor(TabHeaderListState)
final tabHeaderListStateProvider =
    NotifierProvider<TabHeaderListState, List<TabHeader>>.internal(
  TabHeaderListState.new,
  name: r'tabHeaderListStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabHeaderListStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabHeaderListState = Notifier<List<TabHeader>>;
String _$tabContentStateHash() => r'3f12049b4d1d0855de112028e7b70ccf37eb7563';

/// See also [TabContentState].
@ProviderFor(TabContentState)
final tabContentStateProvider =
    NotifierProvider<TabContentState, List<Widget>>.internal(
  TabContentState.new,
  name: r'tabContentStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabContentStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabContentState = Notifier<List<Widget>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
