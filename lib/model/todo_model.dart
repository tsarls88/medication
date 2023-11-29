import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docID;
  final String sugarConcentration;
  final String notes;
  final String dateTask;
  final String timeTask;

  TodoModel({
    this.docID,
    required this.sugarConcentration,
    required this.notes,
    required this.dateTask,
    required this.timeTask,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'docID': docID,
      'sugarConcentration': sugarConcentration,
      'notes': notes,
      'dateTask': dateTask,
      'timeTask': timeTask,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map,
      {required String sugarConcentration}) {
    return TodoModel(
      docID: map['docID'] != null ? map['docID'] as String : null,
      sugarConcentration: map['sugarConcentration'] as String,
      notes: map['notes'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docID: doc.id,
      sugarConcentration: doc['sugarConcentration'],
      notes: doc['notes'],
      dateTask: doc['dateTask'],
      timeTask: doc['timeTask'],
    );
  }
}
