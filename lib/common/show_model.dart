import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';
// import 'package:medication/common/convert_time.dart';
import 'package:medication/common/interval_selection_widget.dart';
import 'package:medication/common/medicine_type.dart';
import 'package:medication/global_bloc.dart';
import 'package:medication/pages/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import 'package:medication/common/select_time_widget.dart';
import 'package:medication/common/select_date_widget.dart';

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

  String? medicineName;
  String? dosage;

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
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
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
                onChanged: (value) {
                  setState(() {
                    medicineName = value;
                  });
                },
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
                onChanged: (value) {
                  setState(() {
                    dosage = value;
                  });
                },
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
                  titleText: 'mm',
                  valueText: 'dd',
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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                    color: Colors.grey.shade300,
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 11.0,
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
