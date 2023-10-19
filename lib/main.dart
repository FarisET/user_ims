import 'package:flutter/material.dart';
import 'package:user_ims/pages/home_page.dart';
import 'package:user_ims/pages/login_page.dart';
import 'package:user_ims/pages/user_form.dart';
import 'package:user_ims/widgets/report_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
        routes: {
    '/home_page':(context) => const HomePage(),
    '/form_page': (context) => const UserForm(),
    //'login_page':(context) => const LoginPage(),
  },
    );
  }
}