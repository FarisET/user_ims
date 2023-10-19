// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_ims/models/ApiError.dart';
import 'package:user_ims/models/ApiResponse.dart';
import 'package:user_ims/services/UserServices.dart';

import '../models/user.dart';



class LoginPage extends StatelessWidget {
  
  final TextEditingController cuserid = new TextEditingController();
  final TextEditingController cpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incident Reporting'),
        leading: IconButton(
            icon: const Icon(Icons.menu, semanticLabel: 'menu'),
            onPressed: () {
              //  print('Menu button');
            }),
        actions: [
          IconButton(
              onPressed: () {
                // print('search button');
              },
              icon: const Icon(
                Icons.search,
                semanticLabel: 'search',
              )),
          IconButton(
              onPressed: () {
                print('filter button');
              },
              icon: const Icon(
                Icons.filter,
                semanticLabel: 'filter',
              ))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(children: [
          SizedBox(
            height: 80,
          ),
          Column(
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
                    TextButton(onPressed: () {}, child: Text('CANCEL')),
                    ElevatedButton(onPressed: () {
                      handleSubmitted(context);
                    }, child: Text('NEXT'))
                  ],
                ),
              )
            ],
          )
        ]),
      )),
    );
  }
  

Widget makeInput({label, controller_val, obscureText = false}) {
       return TextField(
          controller: controller_val,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
          ),
        );
}

void handleSubmitted(BuildContext context) async {
  UserServices userServices = new UserServices();
  ApiResponse _apiResponse = await
  userServices.login(cuserid.text, cpassword.text);
  //print(_apiResponse.ApiError);
  if (_apiResponse.ApiError == null) {
    if (_apiResponse.Data != null && _apiResponse.Data is User) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", (_apiResponse.Data as User).user_id);
      Navigator.pushNamed(context, '/home_page');
    } else {
      // Fluttertoast.showToast(
      //   msg: 'Login Failed (Data is not in the expected format)',
      //   toastLength: Toast.LENGTH_SHORT,
      // );
      print('Login Failed (Data is not in the expected format)');
    }
  } else {
    // Fluttertoast.showToast(
    //   msg: 'Login Failed (ApiError is not null)',
    //   toastLength: Toast.LENGTH_SHORT,
    // );
    print('Login Failed (ApiError is not null)');
  }
}
     //   Navigator.pushNamedAndRemoveUntil(
    //     context,
    //     '/loadDash',
    //     ModalRoute.withName('/loadDash'),
    //     arguments: isadminstored,
    //   );
}

