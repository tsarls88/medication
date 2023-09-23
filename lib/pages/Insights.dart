import 'package:flutter/material.dart';

class UserInsights extends StatefulWidget {
  const UserInsights({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserInsightsState createState() => _UserInsightsState();
}

class _UserInsightsState extends State<UserInsights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('INSIGHTS'),
      ),
    );
  }
}
