import 'package:medication/common/errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:medication/common/medicine_type.dart';

class NewEntryBloc {
  BehaviorSubject<MedicineType>? _selectedMedicineType$;
  ValueStream<MedicineType> get selectedMedicineType =>
      _selectedMedicineType$!.stream;

  BehaviorSubject<int>? _selectedInterval$;
  BehaviorSubject<int>? get selectedIntervals => _selectedInterval$;

  BehaviorSubject<String>? _selectedTimeOfDay$;
  BehaviorSubject<String>? get selectedTimeOfDay => _selectedTimeOfDay$;

  BehaviorSubject<String>? _selectedDateOfDays$;
  BehaviorSubject<String>? get selectedDateOfDays => _selectedTimeOfDay$;

  BehaviorSubject<EntryError>? _errorState$;
  BehaviorSubject<EntryError>? get errorState => _errorState$;

  NewEntryBloc() {
    _selectedMedicineType$ =
        BehaviorSubject<MedicineType>.seeded(MedicineType.None);

    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded('none');
    _selectedDateOfDays$ = BehaviorSubject<String>.seeded('none');
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {
    _selectedMedicineType$!.close();
    _selectedTimeOfDay$!.close();
    _selectedInterval$!.close();
    _selectedDateOfDays$!.close();
  }

  void submitError(EntryError error) {
    _errorState$!.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$!.add(interval);
  }

  void updateTime(String time) {
    _selectedTimeOfDay$!.add(time);
  }

  void updateDate(String date) {
    _selectedDateOfDays$!.add(date);
  }

  void updateSelectedMedicine(MedicineType type) {
    MedicineType _tempType = _selectedMedicineType$!.value;
    if (type == _tempType) {
      _selectedMedicineType$!.add(MedicineType.None);
    } else {
      _selectedMedicineType$!.add(type);
    }
  }
}
