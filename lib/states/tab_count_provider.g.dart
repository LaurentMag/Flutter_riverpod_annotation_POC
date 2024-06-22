// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setTabHeaderWidgetsHash() =>
    r'fd935723b45cbfeec73bd00382d05fe55e03836b';

/// Create the list of tab headers
/// watch the tabHeaderListStateProvider to create the list when it changes
///
/// Copied from [setTabHeaderWidgets].
@ProviderFor(setTabHeaderWidgets)
final setTabHeaderWidgetsProvider = Provider<List<Widget>>.internal(
  setTabHeaderWidgets,
  name: r'setTabHeaderWidgetsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$setTabHeaderWidgetsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SetTabHeaderWidgetsRef = ProviderRef<List<Widget>>;
String _$tabIndexStateHash() => r'd4c18f894d7426c83f6606c435010138f4bb4491';

/// Handle the index of the selected tab
///
/// Copied from [TabIndexState].
@ProviderFor(TabIndexState)
final tabIndexStateProvider = NotifierProvider<TabIndexState, int>.internal(
  TabIndexState.new,
  name: r'tabIndexStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabIndexStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabIndexState = Notifier<int>;
String _$tabHeaderStateHash() => r'91f4c99614a6249189feab46c20f754996031d2c';

/// Handle the list of tab headers
///
/// Copied from [TabHeaderState].
@ProviderFor(TabHeaderState)
final tabHeaderStateProvider =
    NotifierProvider<TabHeaderState, List<TabHeader>>.internal(
  TabHeaderState.new,
  name: r'tabHeaderStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$tabHeaderStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TabHeaderState = Notifier<List<TabHeader>>;
String _$tabContentStateHash() => r'1f2895eeb6f719ba740ba58af22335a41c160c7f';

/// Handle the list of tab content
///
/// Copied from [TabContentState].
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
