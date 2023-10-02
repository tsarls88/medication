import 'package:flutter/material.dart';
import 'package:medication/pages/new_entry/new_entry_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NewEntryBloc? newEntryBloc;

  @override
  void initState() {
    newEntryBloc = NewEntryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<NewEntryBloc>.value(
      value: newEntryBloc!,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            theme: ThemeData(primarySwatch: Colors.lightBlue),
          );
        },
      ),
    );
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: const HomePage(),
  //     theme: ThemeData(primarySwatch: Colors.lightBlue),
  //   );
  // }

