// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(listQuotes)
const listQuotesProvider = ListQuotesProvider._();

final class ListQuotesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  const ListQuotesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'listQuotesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$listQuotesHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return listQuotes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$listQuotesHash() => r'3c3064e66a4369dfd23e9ba1820f069cfdc8e4ea';

@ProviderFor(randomQuote)
const randomQuoteProvider = RandomQuoteProvider._();

final class RandomQuoteProvider
    extends $FunctionalProvider<String, String, String> with $Provider<String> {
  const RandomQuoteProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'randomQuoteProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$randomQuoteHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return randomQuote(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$randomQuoteHash() => r'a29206dd310ba263a7d70bec07101984ecd416e3';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
