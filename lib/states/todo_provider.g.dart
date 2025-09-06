// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ToDoState)
const toDoStateProvider = ToDoStateProvider._();

final class ToDoStateProvider
    extends $NotifierProvider<ToDoState, List<ToDoModel>> {
  const ToDoStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'toDoStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$toDoStateHash();

  @$internal
  @override
  ToDoState create() => ToDoState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ToDoModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ToDoModel>>(value),
    );
  }
}

String _$toDoStateHash() => r'f2385b8570f261dbc20c144786fb59a434f35e3b';

abstract class _$ToDoState extends $Notifier<List<ToDoModel>> {
  List<ToDoModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<ToDoModel>, List<ToDoModel>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<ToDoModel>, List<ToDoModel>>,
        List<ToDoModel>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
