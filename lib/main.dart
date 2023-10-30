import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_ims/models/incident_type_provider.dart';
import 'package:user_ims/pages/home_page.dart';
import 'package:user_ims/pages/login_page.dart';
import 'package:user_ims/pages/user_form.dart';

import 'pages/error_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<IncidentProviderClass>(create: (context) => IncidentProviderClass())
    ],
      child: MaterialApp(
          onUnknownRoute: (settings) {
      return MaterialPageRoute(
        builder: (context) => const ErrorPage(), // Replace with your error handling page
      );
      },
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
          routes: {
      '/home_page':(context) => const HomePage(),
      '/form_page': (context) => const UserForm(),
      //'login_page':(context) => const LoginPage(),
      },
      ),
    );
  }
}