// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:user_ims/services/UserServices.dart';
import 'package:user_ims/widgets/report_tile.dart';

import 'login_page.dart';

// ignore_for_file: prefer_const_constructors

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: Text('Incident Reporting'),
        actions: [
            SizedBox(
              height: 100,
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  // Perform logout actions here
                  handleLogout(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
        ],        ),
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
                  children:[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              
                        Text('Hi, Faris!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(intl.DateFormat.yMd().format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ) 
                          ),
                           

                        ],
                            
                          
                    ),
                
                    //Profile
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12)
              
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(Icons.person,
                        ),
                      ),
                    )
                  ]
                    
                
                  
                ),

              SizedBox(
                height: 40,
              ),

              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
              ),

                  ), 
                  onPressed: (){
                    Navigator.pushNamed(context, '/form_page');
                  }, 
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Report an Incident',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    
                  
                    )
                    ),
                  )
                  
                                  
                  ),
                  ),



                  ]
                ),
              ),


              SizedBox(
                height: 30,
              ),
              
                //Previous reports
                  Container
                  (
                    decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0), // Adjust the radius as needed
                      topRight: Radius.circular(20.0),
                    )
                  
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Previous Reports',
                        style: TextStyle(
                          fontSize:24,
                          fontWeight: FontWeight.bold,
                          
                          ),),

                        SizedBox(
                          height: 10,
                        ),

                        ReportTile()

                        
                      ]
                    )   



              

      ))]),
        ),
    
    );
  }


  void handleLogout(BuildContext context) async {
    UserServices userServices = UserServices(context);
    await userServices.logout();
  }
}

