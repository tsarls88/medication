import 'package:flutter/material.dart';

class UserCalendar extends StatelessWidget {
  const UserCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('CALENDAR'),
      ),
    );
  }
}
