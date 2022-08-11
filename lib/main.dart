import 'dart:developer';

import 'package:advocate/Authentication/login_page.dart';
import 'package:advocate/firebase_options.dart';
import 'package:advocate/screens/Home_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  //firebase initilization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      log("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      initialRoute: "login",
      routes: {
        "home": (context) => const MyHomePage(),
        "login": (context) => const LoginScreen(),
      },
    );
  }
}
