import 'package:ez_split/model/notifer_map.dart';
import 'package:ez_split/model/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final peopleProvider =
    ChangeNotifierProvider.autoDispose<NotifierMap<String, double>>((ref) {
  ref.maintainState = true;
  return NotifierMap<String, double>();
});

final paidProvider =
    ChangeNotifierProvider.autoDispose<NotifierMap<String, bool>>((ref) {
  ref.maintainState = false;
  final people = ref.watch(peopleProvider);
  return NotifierMap<String, bool>(
      initialValues: Map.fromIterable(
    people.map.keys,
    value: (element) => false,
  ));
});

final feesProvider =
    ChangeNotifierProvider.autoDispose<NotifierMap<String, double>>((ref) {
  ref.maintainState = true;
  return NotifierMap<String, double>();
});

final taxProvider =
    ChangeNotifierProvider.autoDispose<ValueNotifier<double>>((ref) {
  ref.maintainState = true;
  return ValueNotifier<double>(0.07);
});

final totalProvider =
    ChangeNotifierProvider.autoDispose<ValueNotifier<double>>((ref) {
  ref.maintainState = true;
  final people = ref.watch(peopleProvider).map;
  final fees = ref.watch(feesProvider).map;
  final tax = ref.watch(taxProvider).value;
  final peopleTotal = people.values.fold<double>(0, (a, b) => a + b);
  final feesTotal = fees.values.fold<double>(0, (a, b) => a + b);
  return ValueNotifier(peopleTotal + feesTotal + (peopleTotal * tax));
});

final appThemeProvider = ChangeNotifierProvider.autoDispose<AppTheme>(((ref) {
  ref.maintainState = true;
  return AppTheme();
}));
