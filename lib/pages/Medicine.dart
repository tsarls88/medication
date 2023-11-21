import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:medication/common/Medicine_main.dart';
// import 'package:medication/common/medicine_type.dart';
import 'package:medication/common/show_model.dart';
import 'package:medication/global_bloc.dart';
import 'package:medication/medicine_details/medicine_details.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Insights.dart';
import 'Calendar.dart';
import 'Settings.dart';
import 'package:intl/intl.dart';
// import 'package:medication/common/medicine_type.dart';

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
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    DateTime now = DateTime.now();
    String currentDate = DateFormat('EEEE, d MMMM').format(now);

    var $ScreenHeight = MediaQuery.of(context).size.height / 100;
    // var $ScreenWidth = MediaQuery.of(context).size.width / 100;
    final scrollController = ScrollController();

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
      body: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 0.5.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s Medicine List',
                          style: TextStyle(
                              fontSize: $ScreenHeight * 1.8,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                        builder: (context) => const AddNewTaskModel(),
                      ),
                      child: Text(
                        '+ Add Medicine',
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
              StreamBuilder<List<Medicine>>(
                stream: globalBloc.medicineList$,
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: 1.h,
                    ),
                    child: Text(
                      !snapshot.hasData
                          ? 'No Medicine Listed'
                          : snapshot.data!.length.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.black,
                            fontSize: $ScreenHeight * 2.3,
                          ),
                    ),
                  );
                },
              ),
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
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    var $ScreenHeight = MediaQuery.of(context).size.height / 100;
    var $ScreenWidth = MediaQuery.of(context).size.width / 100;

    return StreamBuilder(
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Medicine',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.red,
                    fontSize: $ScreenHeight * 2.3,
                  ),
            ),
          );
        } else {
          final scrollController = ScrollController();
          return Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Container(
                height: $ScreenHeight * 100,
                width: $ScreenWidth * 100,
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: GridView.builder(
                  padding: const EdgeInsets.only(top: 1),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MedicinceCard(
                      medicine: snapshot.data![index],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class MedicinceCard extends StatelessWidget {
  const MedicinceCard({Key? key, required this.medicine}) : super(key: key);
  final Medicine medicine;

  Hero makeIcon(double size) {
    if (medicine.medicineType == 'Bottle') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/bottle.svg',
          height: 7.h,
        ),
      );
    } else if (medicine.medicineType == 'Pill') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/pill.svg',
          height: 7.h,
        ),
      );
    } else if (medicine.medicineType == 'Syringe') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/syringe.svg',
          height: 7.h,
        ),
      );
    } else if (medicine.medicineType == 'Tablet') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/tablet.svg',
          height: 7.h,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName! + medicine.medicineType!,
      child: Icon(
        Icons.error,
        color: Colors.greenAccent,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var $ScreenHeight = MediaQuery.of(context).size.height / 100;
    var $ScreenWidth = MediaQuery.of(context).size.width / 100;
    return Container(
      height: $ScreenHeight * 100,
      width: $ScreenWidth * 100,
      margin: const EdgeInsets.symmetric(vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
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
                EdgeInsets.only(left: 2.w, right: 2.w, top: 0.h, bottom: 0.h),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeIcon(
                  5.h,
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: makeIcon(),
                //   // child: SvgPicture.asset(
                //   //   'assets/bottle.svg',
                //   //   height: 8.h,
                //   //   // ignore: deprecated_member_use
                //   //   color: Colors.greenAccent,
                //   // ),
                // ),
                Text(
                  // 'Biogesic',
                  medicine.medicineName!,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.green,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  '8mg',
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.blue,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const Gap(2),
                Text(
                  medicine.interval == 1
                      ? "Every ${medicine.interval} Hour"
                      : "Every ${medicine.interval} Hour",
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
        ),
      ),
    );
  }
}
