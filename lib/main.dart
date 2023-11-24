import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medication/firebase_options.dart';
import 'package:medication/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalBloc? globalBloc;
  // NewEntryBloc? newEntryBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    // newEntryBloc = NewEntryBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      // value: newEntryBloc!,
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
