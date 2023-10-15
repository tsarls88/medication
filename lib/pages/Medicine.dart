import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:medication/common/medicine_type.dart';
import 'package:medication/common/show_model.dart';
import 'package:medication/medicine_details/medicine_details.dart';
import 'package:sizer/sizer.dart';
import 'Insights.dart';
import 'Calendar.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';

class UserMedi extends StatefulWidget {
  const UserMedi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserMediState createState() => _UserMediState();
}

class _UserMediState extends State<UserMedi> {
  int _selectedIndex = 0;

  void _navigationBottomBar(int index) {
    if (index == 0 && _selectedIndex == index) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else if (index == 1 && _selectedIndex == index) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserInsights()),
      );
    } else if (index == 2 && _selectedIndex == index) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserCalendar()),
      );
    } else if (index == 3 && _selectedIndex == index) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserSettings()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('EEEE, d MMMM').format(now);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today\'s Medicine List',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        currentDate,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD5E8FA),
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      context: context,
                      builder: (context) => const AddNewTaskModel(),
                    ),
                    child: const Text('+ Add Medicine'),
                  ),
                ],
              ),
              const Gap(7),
              const BottomContainer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigationBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.insights_outlined), label: 'Insights'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      width: 660.w,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 3),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MedicineDetails(),
                ),
              );
            },
            child: Container(
              padding:
                  EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h, bottom: 1.h),
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/bottle.svg',
                    height: 7.h,
                    // ignore: deprecated_member_use
                    color: Colors.greenAccent,
                  ),
                  const Spacer(),
                  Text(
                    'Calpol',
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    '8mg',
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Every 8 Hours',
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    '2:16PM',
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  Text(
                    '10/16/23',
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
