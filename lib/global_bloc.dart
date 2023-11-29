// import 'dart:convert';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:medication/common/Medicine_main.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class GlobalBloc {
//   BehaviorSubject<List<Medicine>>? _medicineList$;
//   BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;

//   GlobalBloc() {
//     _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
//     makeMedicineList();
//   }

//   Future removeMedicine(Medicine toBeRemoved) async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     SharedPreferences sharedUser = await SharedPreferences.getInstance();
//     List<String> medicineJsonList = [];

//     var blockList = _medicineList$!.value;
//     blockList.removeWhere(
//         (medicine) => medicine.medicineName == toBeRemoved.medicineName);

//     for (int i = 0; i < (24 / toBeRemoved.interval!).floor(); i++) {
//       flutterLocalNotificationsPlugin
//           .cancel(int.parse(toBeRemoved.notificationIDs![i]));
//     }
//     if (blockList.isNotEmpty) {
//       for (var blockMedicine in blockList) {
//         String medicineJson = jsonEncode(blockMedicine.toJson());
//         medicineJsonList.add(medicineJson);
//       }
//     }
//     sharedUser.setStringList('medicines', medicineJsonList);
//     _medicineList$!.add(blockList);
//   }

//   Future<void> updateMedicineList(Medicine newMedicine) async {
//     List<Medicine> medicineList = _medicineList$!.value;
//     medicineList.add(newMedicine);
//     _medicineList$!.add(medicineList);

//     SharedPreferences sharedUser = await SharedPreferences.getInstance();
//     List<String> medicineJsonList = sharedUser.getStringList('medicines') ?? [];
//     medicineJsonList.add(jsonEncode(newMedicine.toJson()));
//     await sharedUser.setStringList('medicines', medicineJsonList);
//   }

//   Future<void> makeMedicineList() async {
//     SharedPreferences sharedUser = await SharedPreferences.getInstance();
//     List<String>? jsonList = sharedUser.getStringList('medicines');
//     List<Medicine> prefList = [];

//     if (jsonList != null) {
//       for (String jsonMedicine in jsonList) {
//         dynamic userMap = jsonDecode(jsonMedicine);
//         Medicine tempMedicine = Medicine.fromJson(userMap);
//         prefList.add(tempMedicine);
//       }
//     }

//     _medicineList$!.add(prefList);
//   }

//   void dispose() {
//     _medicineList$!.close();
//   }
// }
