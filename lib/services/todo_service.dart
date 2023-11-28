import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medication/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todo App');

  // CREATE
  void addTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //DELETE
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
