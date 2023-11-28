import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sugarConcentrationProvider = StateProvider<String>((ref) {
  return '';
});

final dateProvider = StateProvider<String>((ref) {
  return 'dd/mm/yy';
});

final timeProvider = StateProvider<String>((ref) {
  return 'hh : mm';
});
