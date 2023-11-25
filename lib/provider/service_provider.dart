import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medication/model/todo_model.dart';
import 'package:medication/services/todo_service.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final serviceProvider = StateProvider<TodoService>(
//   (ref) {
//     return TodoService();
//   },
// );

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('todo App')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;

  return;
});
