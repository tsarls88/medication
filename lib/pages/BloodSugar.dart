import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medication/Widget/card_todo_widget.dart';
import 'package:medication/common/show_Bsugar_model.dart';
import 'package:medication/pages/Calendar.dart';
import 'package:medication/pages/Insights.dart';
import 'package:medication/pages/Settings.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class BloodSugar extends StatefulWidget {
  const BloodSugar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BloodSugarState createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
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
    var $ScreenHeight = MediaQuery.of(context).size.height / 100;
    var $ScreenWidth = MediaQuery.of(context).size.width / 100;
    DateTime now = DateTime.now();
    final scrollController = ScrollController();

    String currentDate = DateFormat('EEEE, d MMMM').format(now);

    return ProviderScope(
      child: Scaffold(
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
        body: ProviderScope(
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today\'s Blood Sugar List',
                              style: TextStyle(
                                fontSize: $ScreenHeight * 1.8,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              currentDate,
                              style: TextStyle(
                                fontSize: $ScreenHeight * 1.8,
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
                            builder: (context) => const AddSugarTaskModel(),
                          ),
                          child: Text(
                            '+ Add List',
                            style: TextStyle(
                              fontSize: $ScreenHeight * 1.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: $ScreenHeight * 0.1,
                  ),
                  // Card List Task
                  Gap(18),
                  ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const CardToDoListWidget(),
                  ),
                ],
              ),
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
      ),
    );
  }
}
