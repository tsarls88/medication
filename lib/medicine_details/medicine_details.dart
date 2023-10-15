// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails({super.key});

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                'assets/bottle.svg',
                height: 18.h,
                // ignore: deprecated_member_use
                color: Colors.greenAccent,
              ),
              const Column(
                children: [
                  MainInfoTab(
                    FieldInfo: 'Calpol',
                    FieldTitle: 'Medicine Name',
                  ),
                  Gap(7),
                  MainInfoTab(
                    FieldInfo: '8 mg',
                    FieldTitle: 'Dosage',
                  ),
                ],
              ),
            ],
          ),
          const Gap(9),
          const ExtendedInfoTab(
            FieldTitle: 'Medicine Type',
            FieldInfo: 'Pill',
          ),
          const ExtendedInfoTab(
            FieldTitle: 'Dose Interval',
            FieldInfo: 'Every 8 Hours | 3 times a day',
          ),
          const ExtendedInfoTab(
            FieldTitle: 'Start Time',
            FieldInfo: '2:16PM',
          ),
          const ExtendedInfoTab(
            FieldTitle: 'Date',
            FieldInfo: '10/15/23',
          ),
        ],
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  const MainInfoTab(
      {Key? key, required this.FieldInfo, required this.FieldTitle})
      : super(key: key);

  final String FieldTitle;
  final String FieldInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45.w,
      height: 6.5.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              FieldTitle,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              FieldInfo,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.green,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  const ExtendedInfoTab(
      {super.key, required this.FieldTitle, required this.FieldInfo});

  final String FieldTitle;
  final String FieldInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Text(
                FieldTitle,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              FieldInfo,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.green,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
