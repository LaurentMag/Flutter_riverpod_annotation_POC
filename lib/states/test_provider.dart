import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_provider.g.dart';

@riverpod
List<String> listQuotes(ListQuotesRef ref) {
  return [
    "The greatest glory in living lies not in never falling, but in rising every time we fall.",
    "The way to get started is to quit talking and begin doing.",
    "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking.",
    "If life were predictable it would cease to be life, and be without flavor.",
    "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success.",
    "Life is what happens when you're busy making other plans.",
    "Spread love everywhere you go. Let no one ever come to you without leaving happier.",
  ];
}

@riverpod
String randomQuote(RandomQuoteRef ref) {
  final quotes = ref.watch(listQuotesProvider);
  final String randomQuote = quotes[Random().nextInt(quotes.length)];

  return randomQuote;
}
