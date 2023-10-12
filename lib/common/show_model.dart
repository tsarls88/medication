import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
import 'package:medication/common/convert_time.dart';
import 'package:medication/common/medicine_type.dart';
import 'package:medication/pages/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';

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

  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldkey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();

    _newEntryBloc = NewEntryBloc();
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
      child: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Add New Medicine',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Gap(12),
            const PanelTitle(
              title: 'Medicine Name',
              isRequired: false,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Add Medicine Name',
                ),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(),
              ),
            ),
            const Gap(7),
            const PanelTitle(
              title: 'Dosage in Mg',
              isRequired: true,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: dosageController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: 'Add Dosage',
                ),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            const Gap(7),
            const PanelTitle(title: 'Medicine Type', isRequired: true),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: StreamBuilder<MedicineType>(
                // new entry block
                stream: _newEntryBloc.selectedMedicineType,
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
                        isSelected: snapshot.data == MedicineType.syringe
                            ? true
                            : false,
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
                // stream: null,
              ),
            ),
            const Gap(4),
            const PanelTitle(title: 'Interval Selection', isRequired: true),
            const IntervalSelection(),
            // const SelectDate(),
            const Gap(4),
            const PanelTitle(title: 'Select Date and Time', isRequired: true),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectTime(
                  titleText: 'Time',
                  valueText: 'hh/mm',
                  iconSection: CupertinoIcons.clock,
                ),
                Gap(15),
                SelectDate(
                  titleText: 'Time',
                  valueText: 'hh/mm',
                  iconSection: CupertinoIcons.calendar,
                ),
              ],
            ),
            const Gap(11),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                    ),
                    child: const Text('Cancel'),
                    onPressed: () {},
                  ),
                ),
                const Gap(11),
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Confirm'),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 50,
            //     right: 50,
            //   ),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.shade500,
            //           offset: const Offset(4.0, 4.0),
            //           blurRadius: 15.0,
            //           spreadRadius: 1.0,
            //         ),
            //       ],
            //     ),
            //     child: SizedBox(
            //       width: 350,
            //       height: 35,
            //       child: TextButton(
            //         style: TextButton.styleFrom(
            //           backgroundColor: Colors.blueAccent.shade200,
            //           shape: const StadiumBorder(),
            //         ),
            //         child: Center(
            //           child: Text(
            //             'Confirm',
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .titleMedium!
            //                 .copyWith(color: Colors.black),
            //           ),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
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
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        // SELECT MEDICINE TYPE
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 65,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isSelected ? Colors.white : Colors.white,
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
                  top: 10,
                  bottom: 10,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 50,
                  // ignore: deprecated_member_use
                  color: isSelected ? Colors.red : Colors.greenAccent,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 55,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
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
              iconEnabledColor: Colors.black,
              dropdownColor: Colors.white,
              // itemHeight: 0.80,
              hint: _selected == 0
                  ? Text(
                      'Select Interval',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
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
  const SelectTime({
    Key? key,
    required this.titleText,
    required this.valueText,
    required this.iconSection,
  }) : super(key: key);

  final String titleText;
  final String valueText;
  final IconData iconSection;

  @override
  // ignore: library_private_types_in_public_api
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 0);
  bool _clicked = false;
  // ignore: unused_field
  late String _selectedTimeFormat;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _selectedTimeFormat = picked.period == DayPeriod.am ? 'AM' : 'PM';
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              _selectTime();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(widget.iconSection),
                  const SizedBox(width: 10),
                  Text(
                    _clicked == false
                        ? "Select Time"
                        : convertTime(_time.hour, _time.minute),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectDate extends StatefulWidget {
  const SelectDate(
      {Key? key,
      required String titleText,
      required String valueText,
      required IconData iconSection})
      : super(key: key);

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat.yMd().format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          GestureDetector(
            onTap: _selectDate, // Fix: Remove extra onTap declaration
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 10),
                  Text(
                    _dateController.text.isNotEmpty
                        ? _dateController.text
                        : "Select Date",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
