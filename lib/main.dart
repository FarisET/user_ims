import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_ims/actionTeam_pages/action_team_home_page.dart';
import 'package:user_ims/admin_pages/admin_home_page.dart';
import 'package:user_ims/models/incident_type_provider.dart';
import 'package:user_ims/pages/home_page.dart';
import 'package:user_ims/pages/login_page.dart';
import 'package:user_ims/pages/user_form.dart';

import 'models/incident_subtype_provider.dart';
import 'pages/error_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<IncidentProviderClass>(create: (context) => IncidentProviderClass()),
      ChangeNotifierProvider<SubIncidentProviderClass>(create: (context) => SubIncidentProviderClass())
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
      '/admin_home_page': (context) => const AdminHomePage(),
      '/action_team_home_page': (context) => const ActionTeamHomePage()
      },
      ),
    );
  }
}