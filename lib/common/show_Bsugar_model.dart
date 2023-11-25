import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medication/Widget/date_time_widget.dart';
import 'package:medication/Widget/textfield_Widget.dart';
import 'package:medication/provider/date_time_provider.dart';
import 'package:riverpod/riverpod.dart';

class AddSugarTaskModel extends ConsumerWidget {
  const AddSugarTaskModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateProv = ref.watch(dateProvider);
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
          children: [
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
            const TextFieldWidget(maxLine: 1, hintText: 'mmol/L'),
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
            const TextFieldWidget(maxLine: 5, hintText: 'Add Description'),
            const Gap(10),
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
                    onPressed: () {},
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
