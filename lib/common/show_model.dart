import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medication/common/convert_time.dart';
import 'package:medication/common/medicine_type.dart';
import 'package:medication/pages/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';

class AddNewTaskModel extends StatefulWidget {
  const AddNewTaskModel({Key? key}) : super(key: key);

  @override
  State<AddNewTaskModel> createState() => _AddNewTaskModelState();
}

// PANEL TITLE
class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 2,
      ),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            TextSpan(
              text: isRequired ? " * " : "",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.red,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _AddNewTaskModelState extends State<AddNewTaskModel> {
  late TextEditingController nameController;
  late TextEditingController dosageController;

  // late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldkey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    // _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();

    // _newEntryBloc = NewEntryBloc();
    _scaffoldkey = GlobalKey<ScaffoldState>();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<GlobalKey<ScaffoldState>>(
          '_scaffoldkey', _scaffoldkey),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      key: _scaffoldkey,
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      // child: Provider<NewEntryBloc>.value(
      //   value: _newEntryBloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add New Medicine',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Divider(),
          const PanelTitle(
            title: 'Medicine Name',
            isRequired: false,
          ),
          TextFormField(
            maxLength: 12,
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(),
          ),
          const PanelTitle(
            title: 'Dosage in Mg',
            isRequired: true,
          ),
          TextFormField(
            maxLength: 12,
            controller: dosageController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            style: Theme.of(context).textTheme.titleSmall!.copyWith(),
          ),
          const SizedBox(
            height: 2,
          ),
          const PanelTitle(title: 'Medicine Type', isRequired: true),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: StreamBuilder(
              // new entry block
              // stream: _newEntryBloc.selectedMedicineType,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MedicineTypeColumn(
                      medicineType: MedicineType.bottle,
                      name: 'Bottle',
                      iconValue: 'assets/bottle.svg',
                      isSelected:
                          snapshot.data == MedicineType.bottle ? true : false,
                    ),
                    MedicineTypeColumn(
                      medicineType: MedicineType.pill,
                      name: 'Pill',
                      iconValue: 'assets/pill.svg',
                      isSelected:
                          snapshot.data == MedicineType.pill ? true : false,
                    ),
                    MedicineTypeColumn(
                      medicineType: MedicineType.syringe,
                      name: 'Syringe',
                      iconValue: 'assets/syringe.svg',
                      isSelected:
                          snapshot.data == MedicineType.syringe ? true : false,
                    ),
                    MedicineTypeColumn(
                      medicineType: MedicineType.tablet,
                      name: 'Tablet',
                      iconValue: 'assets/tablet.svg',
                      isSelected:
                          snapshot.data == MedicineType.tablet ? true : false,
                    ),
                  ],
                );
              },
              stream: null,
            ),
          ),
          const PanelTitle(title: 'Interval Selection', isRequired: true),
          const Divider(),
          const IntervalSelection(),
          const PanelTitle(title: 'Starting Time', isRequired: true),
          const SelectTime(),
        ],
      ),
    );
    // );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn({
    Key? key,
    required this.medicineType,
    required this.name,
    required this.iconValue,
    required this.isSelected,
  }) : super(key: key);
  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    // final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        // SELECT MEDICINE TYPE
        // newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 75,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isSelected ? Colors.white10 : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  )
                ]),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 50,
                  // ignore: deprecated_member_use
                  color: isSelected ? Colors.blueAccent : Colors.greenAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 85,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: isSelected ? Colors.black : Colors.black,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [1, 2, 4, 6, 8, 12, 24];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Remind me every',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          DropdownButton(
              iconEnabledColor: Colors.blue,
              dropdownColor: Colors.white,
              // itemHeight: 0.80,
              hint: _selected == 0
                  ? Text(
                      'Select Interval',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _intervals.map(
                (int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(
                      value.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  );
                },
              ).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal!;
                });
              }),
          Text(
            _selected == 1 ? "Hour" : "Hours",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.black,
                ),
          )
        ],
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const StadiumBorder(),
            ),
            onPressed: () {
              _selectTime();
            },
            child: Center(
              child: Text(
                _clicked == false
                    ? "Select Time"
                    : "${convertTime(_time.hour.toString())} : ${convertTime(_time.minute.toString())}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
