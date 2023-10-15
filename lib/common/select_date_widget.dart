import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
