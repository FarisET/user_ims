// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, non_constant_identifier_names

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_ims/Action%20Team%20Module/pages/action_team_home_page.dart';
import 'package:user_ims/Admin%20Module/admin_pages/admin_home_page.dart';
import 'package:user_ims/User%20Module/pages/home_page.dart';
import 'package:user_ims/User%20Module/services/UserServices.dart';



    class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

      @override
      _LoginPageState createState() => _LoginPageState();
        
    }

    class _LoginPageState extends State<LoginPage> {
      final TextEditingController cuserid =  TextEditingController();
      final TextEditingController cpassword = TextEditingController();
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      UserServices userServices = UserServices();

      @override
      void initState() {
        super.initState();
        checkUserSession();
      }

      void checkUserSession() async {
        final jwt = await userServices.getJwt();
        final role = await userServices.getRole();
        print('jwt;$jwt');
        print('role:$role');
        
        if (jwt != null && role != null) {
          // Use the JWT and role to authenticate and route the user
          if (role == 'admin') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
          } else if (role == 'user') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
          } else if (role == 'action_team') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ActionTeamHomePage()),
                );
          } 
          // else {
          //   // Handle unknown roles or show an error
          // }
        }
      }

//       void checkUserSession() async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         String? userId = prefs.getString("user_id");
//         String? userRole = prefs.getString("role");
//     if (userId !=null && userRole != null) {
//       if (userRole == "admin") {
//         // Navigate to the admin screen
//         Navigator.pushNamed(context, '/admin_home_page');

//       } else if (userRole == "user") {
//         // Navigate to the user screen
//         Navigator.pushNamed(context, '/home_page');

//       } else if (userRole == "action_team") {
//         // Navigate to the user screen
//         Navigator.pushNamed(context, '/action_team_home_page');
      
    
//       // Handle the case where the role is not available in preferences
//       // You can show an error or take some default action
//     }
//   } 
// }
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(children: [
          // SizedBox(
          //   height: 20,
          // ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/safify_logo.png',
                width: 300,
                height: 300,),
                SizedBox(
                  height: 0,
                ),
                Text('Login',
                style: TextStyle(
                 fontSize: 24,
                 fontWeight:FontWeight.bold ),),
                SizedBox(
                  height: 20,
                ),
                makeInput(
                 label: 'Enter your registered id',
                 controller_val: cuserid,
                ),
                SizedBox(
                  height: 12,
                ),
          
                 makeInput(
                 label: 'Enter password',
                 controller_val: cpassword,
                 obscureText: true
                ),
          
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () {
                        closeApp();
                      }, child: Text('CANCEL')),
                      ElevatedButton(onPressed: () {    
                        if (_formKey.currentState!.validate()) {             
                        handleSubmitted(context);
                        }
                      }, child: Text('Login'))
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      )),
    );
  }
  

Widget makeInput({
  String? label,
  TextEditingController? controller_val,
  bool obscureText = false,
  //String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller_val,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
return null;
     } // Add the validation function
  );
}


void handleSubmitted(BuildContext context) async {
  UserServices userServices =  UserServices();
  final loginSuccessful = await userServices.login(cuserid.text.toString(), cpassword.text.toString());
          // Fluttertoast.showToast(
          //   msg: loginSuccessful.toString(),
          //   toastLength: Toast.LENGTH_SHORT,
          // );
  if (loginSuccessful) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", (cuserid.text));
    //  await prefs.setString("user_name", user_name);
  //  String? userRole = prefs.getString("role");

        final jwt = await userServices.getJwt();
        final role = await userServices.getRole();
        print('jwt;$jwt');
        print('role:$role');
        
        if (jwt != null && role != null) {
          // Use the JWT and role to authenticate and route the user
          if (role == 'admin') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHomePage()),
                );
          } else if (role == 'user') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
          } else if (role == 'action_team') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ActionTeamHomePage()),
                );
          } 
          // else {
          //   // Handle unknown roles or show an error
          // }
        }
}
  // else {
        // Fluttertoast.showToast(
        //     msg: "Login Failed",
        //     toastLength: Toast.LENGTH_SHORT,
        //   );

  // }
}

  
  }
  void closeApp() {
    SystemNavigator.pop(); // This will close the app
  }


    
