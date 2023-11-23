import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medication/Widget/textfield_Widget.dart';

class AddSugarTaskModel extends StatefulWidget {
  const AddSugarTaskModel({super.key});

  @override
  State<AddSugarTaskModel> createState() => _AddSugarTaskModelState();
}

class _AddSugarTaskModelState extends State<AddSugarTaskModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.85,
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
        ],
      ),
    );
  }
}
