import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medication/common/convert_time.dart';
import 'package:medication/pages/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';

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
    final NewEntryBloc newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _selectedTimeFormat = picked.period == DayPeriod.am ? 'AM' : 'PM';

        newEntryBloc.updateTime(convertTime(_time.hour, _time.minute) +
            convertTime(_time.hour, _time.minute));
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
