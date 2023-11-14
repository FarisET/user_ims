import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_ims/Action%20Team%20Module/pages/action_team_home_page.dart';
import 'package:user_ims/Admin%20Module/admin_pages/admin_home_page.dart';
import 'package:user_ims/Admin%20Module/providers/action_team_provider.dart';
import 'package:user_ims/Admin%20Module/providers/department_provider.dart';
import 'package:user_ims/User%20Module/providers/fetch_user_report_provider.dart';
import 'package:user_ims/animations/page_transition.dart';
import 'package:user_ims/User%20Module/providers/incident_type_provider.dart';
import 'package:user_ims/User%20Module/pages/home_page.dart';
import 'package:user_ims/User%20Module/pages/login_page.dart';
import 'package:user_ims/User%20Module/pages/user_form.dart';
import 'package:user_ims/User%20Module/providers/location_provider.dart';
import 'package:user_ims/User%20Module/providers/sub_location_provider.dart';

import 'Action Team Module/providers/all_action_reports_approveal_provider.dart';
import 'Action Team Module/providers/all_action_reports_provider.dart';
import 'Action Team Module/providers/fetch_assigned_tasks_provider.dart';
import 'Admin Module/providers/analytics_incident_reported_provider.dart';
import 'Admin Module/providers/analytics_incident_resolved_provider.dart';
import 'Admin Module/providers/fetch_all_user_report_provider.dart';
import 'Admin Module/providers/fetch_countOfSubtypes_provider.dart';
import 'User Module/providers/incident_subtype_provider.dart';
import 'User Module/pages/error_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure WidgetsBinding is initialized
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("user_id");
  String? userRole = prefs.getString("role");

  Widget initialScreen;

  if (userId != null && userRole != null) {
    if (userRole == "admin") {
      initialScreen = AdminHomePage();
    } else if (userRole == "user") {
      initialScreen = HomePage();
    } else if (userRole == "action_team") {
      initialScreen = ActionTeamHomePage();
    } else {
      initialScreen = LoginPage(); // Handle the case where the role is not available
    }
  } else {
    initialScreen = LoginPage(); // Handle the case where user session does not exist
  }

  runApp(MyApp(initialScreen: initialScreen));


}

customAnimations animate = customAnimations();

class MyApp extends StatelessWidget {
 const MyApp({this.initialScreen}) : super();

  final Widget? initialScreen;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<IncidentProviderClass>(create: (context) => IncidentProviderClass()),
      ChangeNotifierProvider<SubIncidentProviderClass>(create: (context) => SubIncidentProviderClass()),
      ChangeNotifierProvider<LocationProviderClass>(create: (context) => LocationProviderClass()),
       ChangeNotifierProvider<SubLocationProviderClass>(create: (context) => SubLocationProviderClass()),
      ChangeNotifierProvider<DepartmentProviderClass>(create: (context) => DepartmentProviderClass()),
       ChangeNotifierProvider<ActionTeamProviderClass>(create: (context) => ActionTeamProviderClass()),
       ChangeNotifierProvider<UserReportsProvider>(create: (context) => UserReportsProvider()),
       ChangeNotifierProvider<AllUserReportsProvider>(create: (context) => AllUserReportsProvider()),
       ChangeNotifierProvider<AssignedTaskProvider>(create: (context) => AssignedTaskProvider()),
       ChangeNotifierProvider<ActionReportsProvider>(create: (context) => ActionReportsProvider()),
       ChangeNotifierProvider<ApprovalStatusProvider>(create: (context) => ApprovalStatusProvider()),
       ChangeNotifierProvider<CountIncidentsResolvedProvider>(create: (context) => CountIncidentsResolvedProvider()),
       ChangeNotifierProvider<CountIncidentsReportedProvider>(create: (context) => CountIncidentsReportedProvider()),
       ChangeNotifierProvider<CountByIncidentSubTypesProviderClass>(create: (context) => CountByIncidentSubTypesProviderClass())



    ],
      child: MaterialApp(
        theme: ThemeData(
        
          useMaterial3: false,
          // ignore: prefer_const_constructors
          pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: _customPageTransitionBuilder(),
            TargetPlatform.iOS: _customPageTransitionBuilder(),
          },
        ),
         ),
          onUnknownRoute: (settings) {
      return MaterialPageRoute(
        builder: (context) => const ErrorPage(), // Replace with your error handling page
      );
      },
      home: initialScreen,
        debugShowCheckedModeBanner: false,
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

 PageTransitionsBuilder _customPageTransitionBuilder() {
    return const _CustomPageTransitionsBuilder();
  }


class _CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  const _CustomPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Implement your custom page transition animation here
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(5, 0.0),
        end: Offset.zero,
        
      ).animate(animation),
      child: child,
    );
  }
}