// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Handle the index of the selected tab
@ProviderFor(TabIndexState)
const tabIndexStateProvider = TabIndexStateProvider._();

/// Handle the index of the selected tab
final class TabIndexStateProvider
    extends $NotifierProvider<TabIndexState, int> {
  /// Handle the index of the selected tab
  const TabIndexStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tabIndexStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tabIndexStateHash();

  @$internal
  @override
  TabIndexState create() => TabIndexState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$tabIndexStateHash() => r'd4c18f894d7426c83f6606c435010138f4bb4491';

abstract class _$TabIndexState extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<int, int>, int, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// Handle the list of tab headers
@ProviderFor(TabHeaderState)
const tabHeaderStateProvider = TabHeaderStateProvider._();

/// Handle the list of tab headers
final class TabHeaderStateProvider
    extends $NotifierProvider<TabHeaderState, List<TabHeader>> {
  /// Handle the list of tab headers
  const TabHeaderStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tabHeaderStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tabHeaderStateHash();

  @$internal
  @override
  TabHeaderState create() => TabHeaderState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TabHeader> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TabHeader>>(value),
    );
  }
}

String _$tabHeaderStateHash() => r'91f4c99614a6249189feab46c20f754996031d2c';

abstract class _$TabHeaderState extends $Notifier<List<TabHeader>> {
  List<TabHeader> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<TabHeader>, List<TabHeader>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<TabHeader>, List<TabHeader>>,
        List<TabHeader>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

/// Create the list of tab headers
/// watch the tabHeaderListStateProvider to create the list when it changes
@ProviderFor(setTabHeaderWidgets)
const setTabHeaderWidgetsProvider = SetTabHeaderWidgetsProvider._();

/// Create the list of tab headers
/// watch the tabHeaderListStateProvider to create the list when it changes
final class SetTabHeaderWidgetsProvider
    extends $FunctionalProvider<List<Widget>, List<Widget>, List<Widget>>
    with $Provider<List<Widget>> {
  /// Create the list of tab headers
  /// watch the tabHeaderListStateProvider to create the list when it changes
  const SetTabHeaderWidgetsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'setTabHeaderWidgetsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$setTabHeaderWidgetsHash();

  @$internal
  @override
  $ProviderElement<List<Widget>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Widget> create(Ref ref) {
    return setTabHeaderWidgets(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Widget> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Widget>>(value),
    );
  }
}

String _$setTabHeaderWidgetsHash() =>
    r'531542a1453ee022d424a6290abcc11ef6536869';

/// Handle the list of tab content
@ProviderFor(TabContentState)
const tabContentStateProvider = TabContentStateProvider._();

/// Handle the list of tab content
final class TabContentStateProvider
    extends $NotifierProvider<TabContentState, List<Widget>> {
  /// Handle the list of tab content
  const TabContentStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'tabContentStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tabContentStateHash();

  @$internal
  @override
  TabContentState create() => TabContentState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Widget> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Widget>>(value),
    );
  }
}

String _$tabContentStateHash() => r'1f2895eeb6f719ba740ba58af22335a41c160c7f';

abstract class _$TabContentState extends $Notifier<List<Widget>> {
  List<Widget> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Widget>, List<Widget>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<Widget>, List<Widget>>,
        List<Widget>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
