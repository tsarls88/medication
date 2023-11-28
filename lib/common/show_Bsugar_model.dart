import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medication/Widget/date_time_widget.dart';
// import 'package:medication/Widget/textfield_Widget.dart';
import 'package:medication/model/todo_model.dart';
import 'package:medication/provider/date_time_provider.dart';
import 'package:medication/provider/service_provider.dart';
import 'package:riverpod/riverpod.dart';

// ignore: must_be_immutable
class AddSugarTaskModel extends ConsumerWidget {
  const AddSugarTaskModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
    // final TextEditingController sugarConcentrationController =
    //     TextEditingController();
    final notesController = TextEditingController();
    final sugarConcentrationState = ref.watch(sugarConcentrationProvider);
    final sugarConcentrationController =
        TextEditingController(text: sugarConcentrationState);

    return ProviderScope(
      child: Container(
        padding: const EdgeInsets.all(30),
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Add New Blood Sugar List',
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
            const Gap(10),
            const Text(
              'Sugar Concentration',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Gap(10),
            TextFormField(
              controller: sugarConcentrationController,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'mmol/L',
              ),
              onChanged: (value) {
                sugarConcentrationState;
              },
            ),
            const Gap(10),
            const Text(
              'Notes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Gap(10),
            TextFormField(
              controller: notesController,
              textCapitalization: TextCapitalization.words,
              maxLines: 5,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Add Description',
              ),
              // onChanged: (value) {
              //   TodoModel.notes = value;
              // },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  titleText: 'Date',
                  valueText: dateProv,
                  iconSection: Icons.calendar_today,
                  onTap: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2030),
                    );
                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  },
                ),
                const Gap(22),
                DateTimeWidget(
                  titleText: 'Time',
                  valueText: ref.watch(timeProvider),
                  iconSection: Icons.access_time,
                  onTap: () async {
                    final getTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (getTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => getTime.format(context));
                    }
                  },
                ),
              ],
            ),
            const Gap(22),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final sugarConcentrationValue =
                          ref.read(sugarConcentrationProvider);
                      final notesValue = notesController.text;
                      final dateTaskValue = ref.read(dateProvider);
                      final timeTaskValue = ref.read(timeProvider);

                      ref.read(serviceProvider).addTask(TodoModel(
                            sugarConcentration: sugarConcentrationValue,
                            notes: notesValue,
                            dateTask: dateTaskValue,
                            timeTask: timeTaskValue,
                          ));
                      // final sugarConcentrationValue =
                      //     ref.read<_TextDataSugarState>().sugarConcentration;
                      // final notesValue =
                      //     ref.read<_TextDataSugarState>().notesController.text;
                      // final dateTaskValue = ref.read(dateProvider);
                      // final timeTaskValue = ref.read(timeProvider);

                      // ref.read(serviceProvider).addTask(TodoModel(
                      //       sugarConcentration: sugarConcentrationValue,
                      //       notes: notesValue,
                      //       dateTask: dateTaskValue,
                      //       timeTask: timeTaskValue,
                      //     ));

                      Navigator.pop(context);

                      // print('Data saved');
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
