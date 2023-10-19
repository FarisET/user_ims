// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:user_ims/widgets/report_tile.dart';

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
      appBar: AppBar(title: Text('Incident Reporting')),
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
                          ) )                 ],
                          
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

                        // Expanded(
                        //   child: ListView(
                        //   children: [
                        //     SingleChildScrollView(
                        //       child: ReportTile(
                        //         title: 'PPE Violation', 
                        //         id: 123456,
                        //         incidentType: 'Unsafe Act',
                        //         description: 'Not wearing gloves while serving',
                        //         location: 'SC Cafeteria',
                        //         risklevel: 'Minor',
                        //         status: true, 
                        //         date: '10/10/23'
                        //         ),
                        //     ),
                        //     SingleChildScrollView(
                        //       child: ReportTile(
                        //         title: 'Loose Chair', 
                        //         id: 73981,
                        //         incidentType: 'Near Miss',
                        //         description: 'Almost fell of Chair',
                        //         location: 'TABBA MTL4',
                        //         risklevel: 'Minor',
                        //         status: true, 
                        //         date: '18/07/23'
                        //         ),
                        //     ),                             
                        //     SingleChildScrollView(
                        //       child: ReportTile(
                        //         title: 'Theft Incident', 
                        //         id: 123456,
                        //         incidentType: 'Safety and Security',
                        //         description: 'Student caught stealing wallet from pocket',
                        //         location: 'Adamjee Cafe',
                        //         risklevel: 'Serious',
                        //         status: false, 
                        //         date: '5/10/23'
                        //         ),
                        //     ),   
                        //     SingleChildScrollView(
                        //       child: ReportTile(
                        //         title: 'Running pipe', 
                        //         id: 123456,
                        //         incidentType: 'Wastage of Resources',
                        //         description: 'Pipe running in fauji ground for 15 minutes',
                        //         location: 'SC Cafeteria',
                        //         risklevel: 'Minor',
                        //         status: true, 
                        //         date: '10/10/23'
                        //         ),
                        //     ),
                        //     SingleChildScrollView(
                        //       child: ReportTile(
                        //         title: 'Missing Student: Faris Ejaz', 
                        //         id: 123456,
                        //         incidentType: 'Entity Lost',
                        //         description: 'Sudent last seen in library yesterday, vansihed since.',
                        //         location: 'SC Cafeteria',
                        //         risklevel: 'Minor',
                        //         status: true, 
                        //         date: '10/10/23'
                        //         ),
                        //     ),

                        //     SingleChildScrollView(
                        //       child: ReportTile(
                        //         title: 'PPE Violation', 
                        //         id: 123456,
                        //         incidentType: 'Unsafe Act',
                        //         description: 'Not wearing gloves while serving',
                        //         location: 'SC Cafeteria',
                        //         risklevel: 'Minor',
                        //         status: true, 
                        //         date: '10/10/23'
                        //         ),
                        //     ),                                                                                                   
                        
                        //     ],
                        //   ),
                        // )

                        
                      ]
                    )   



              

      ))]),
        ),
    
    );
  }
}