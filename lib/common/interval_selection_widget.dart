// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medication/pages/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';

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
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
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
                  newEntryBloc.updateInterval(newVal);
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
