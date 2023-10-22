// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_ims/services/UserServices.dart';



    class LoginPage extends StatefulWidget {
      @override
      _LoginPageState createState() => _LoginPageState();
        
    }

    class _LoginPageState extends State<LoginPage> {
      final TextEditingController cuserid =  TextEditingController();
      final TextEditingController cpassword = TextEditingController();
      final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      @override
      void initState() {
        super.initState();
        checkUserSession();
      }

      void checkUserSession() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userId = prefs.getString("user_id");
        if (userId != null) {
          // User is logged in, navigate to the home screen
          Navigator.pushNamed(context, '/home_page'); // Replace with your home screen route
        }
      }
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(children: [
          SizedBox(
            height: 80,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/palm_logo.png',
                width: 100,
                height: 100,),
                SizedBox(
                  height: 80,
                ),
                Text('Login',
                style: TextStyle(
                 fontSize: 24,
                 fontWeight:FontWeight.bold ),),
                SizedBox(
                  height: 80,
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
    };
     } // Add the validation function
  );
}

// void handleSubmitted(BuildContext context) async {
//   UserServices userServices = new UserServices();
//   ApiResponse _apiResponse = await
//   userServices.login(cuserid.text, cpassword.text);
//   print('Api Response: $_apiResponse');
// //if (_apiResponse.ApiError == null) {
//   if (_apiResponse.StatusCode == 200) {
//     // Status code is 200, indicating success
//  //   if (_apiResponse.Data != null && _apiResponse.Data is User) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString("user_id", (_apiResponse.Data as User).user_id);
//       Navigator.pushNamed(context, '/home_page');
//     // } else {
//     //   print('Login Failed (Data is not in the expected format)');
//     // }
//  // }
//   } else {
//     print('Login Failed (Status Code: ${_apiResponse.StatusCode})');
//   }
// // } else {
// //   print('Login Failed (ApiError is not null)');
// // }
// //}
//      //   Navigator.pushNamedAndRemoveUntil(
//     //     context,
//     //     '/loadDash',
//     //     ModalRoute.withName('/loadDash'),
//     //     arguments: isadminstored,
//     //   );
// }
// }
void handleSubmitted(BuildContext context) async {
  UserServices userServices =  UserServices(context);
  final loginSuccessful = await userServices.login(cuserid.text.toString(), cpassword.text.toString());
          // Fluttertoast.showToast(
          //   msg: loginSuccessful.toString(),
          //   toastLength: Toast.LENGTH_SHORT,
          // );
  if (loginSuccessful) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_id", (cuserid.text));
    print('shared preference: ${prefs.toString()}');
    Navigator.pushNamed(context, '/home_page');  
  } 
  // else {
        // Fluttertoast.showToast(
        //     msg: "Login Failed",
        //     toastLength: Toast.LENGTH_SHORT,
        //   );

  // }

  
  }
  void closeApp() {
    SystemNavigator.pop(); // This will close the app
  }

}

