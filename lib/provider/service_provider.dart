import 'package:medication/services/todo_service.dart';
import 'package:riverpod/riverpod.dart';

final serviceProvider = StateProvider<TodoService>(
  (ref) {
    return TodoService();
  },
);
