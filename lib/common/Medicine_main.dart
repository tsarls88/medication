class Medicine {
  final List<dynamic>? notificationIDs;
  final String? medicineName;
  final String? dosage;
  final String? medicineType;
  final int? interval;
  final String? startTime;
  final String? startDate;

  Medicine({
    this.notificationIDs,
    this.medicineName,
    this.dosage,
    this.interval,
    this.medicineType,
    this.startDate,
    this.startTime,
  });

  String get getName => medicineName!;
  String get getDosage => dosage!;
  String get getType => medicineType!;
  int get getInterval => interval!;
  String get getStartTime => startTime!;
  List<dynamic> get getIDs => notificationIDs!;
  String get getStartDate => startDate!;

  Map<String, dynamic> toJson() {
    return {
      'ids': notificationIDs,
      'name': medicineName,
      'dosage': dosage,
      'type': medicineType,
      'interval': interval,
      'startTime': startTime,
      'startDate': startDate,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> paredJson) {
    return Medicine(
      notificationIDs: paredJson['ids'],
      medicineName: paredJson['name'],
      dosage: paredJson['dosage'],
      medicineType: paredJson['type'],
      interval: paredJson['interval'],
      startTime: paredJson['startTime'],
      startDate: paredJson['startDate'],
    );
  }
}
