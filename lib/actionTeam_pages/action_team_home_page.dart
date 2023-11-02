import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;

import '../pages/login_page.dart';
import '../services/UserServices.dart';

class ActionTeamHomePage extends StatefulWidget {
  const ActionTeamHomePage({Key? key});

  @override
  State<ActionTeamHomePage> createState() => _ActionTeamHomePageState();
}

class _ActionTeamHomePageState extends State<ActionTeamHomePage> {
  String? username;
  String? user_id;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("user_name");
      user_id = prefs.getString("user_id");
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: Text('Action Team Dashboard'),
        actions: [
          SizedBox(
            height: 100,
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                // Perform logout actions here
                handleLogout(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue[600],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //Text
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //TODO: get user name dynamically in welcome
                          Text(
                            'Hi, $username!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            intl.DateFormat.yMd().format(DateTime.now()),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      //Profile
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    void handleLogout(BuildContext context) async {
    UserServices userServices = UserServices(context);
    await userServices.logout();
  }
}
