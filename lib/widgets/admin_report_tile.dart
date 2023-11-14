// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Admin Module/admin_pages/assign_form.dart';
import '../Admin Module/providers/fetch_all_user_report_provider.dart';
import '../models/report.dart';
 
class AdminReportTile extends StatefulWidget {
  const AdminReportTile({super.key});

  @override
  State<AdminReportTile> createState() => _AdminReportTileState();
}

class _AdminReportTileState extends State<AdminReportTile> {

  
  // Widget displayImage(List<dynamic> imageData) {
  //   if (imageData != null) {
  //     List<int> intList = imageData.cast<int>().toList();
  //     print('list int:${intList}');
  //     Uint8List uint8List = Uint8List.fromList(intList);
  //     return Image.memory(uint8List);
  //   } else {
  //     return Text("No image available");
  //   }
  // }
Widget displayImage(Map<String, dynamic> image) {
  if (image != null && image.containsKey('data')) {
    List<dynamic> data = image['data'];
    if (data is List) {
      // Convert the list of dynamic to a list of int
      List<int> intList = data.cast<int>().toList();
      Uint8List uint8List = Uint8List.fromList(intList);
      print('---uint8List: ${uint8List}');
      return Image.memory(uint8List);
    }
  }

  return Text("No image available");
}

// Widget displayImage(Uint8List imageData) {
//   if (imageData != null) {
//     return Image.memory(imageData);
//   } else {
//     return Text("No image available");
//   }
// }

  @override
  void initState() {
    super.initState();
    Provider.of<AllUserReportsProvider>(context, listen: false).fetchAllReports(context);   }





  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<AllUserReportsProvider>(
        builder: (context, allReports,_) {
          if(allReports.reports.isNotEmpty) {
             return ListView.builder(
                itemCount: allReports.reports.length,
                itemBuilder: (context, i) {
                  var item = allReports.reports[i];
            
                  return Card(
                    color: item.status!.contains('open') ? Colors.red[100] : (item.status!.contains('in progress') ? Colors.orange[100] : Colors.green[100]),
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(4),
                    ),
                      // side: BorderSide(
                      //   // color: item.status!.contains('open')?Colors.redAccent:Colors.greenAccent,
                      //    width:1)),                     
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom:0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                          Text(item.incidentSubtypeDescription!,
                                          style: TextStyle(
                                            color: Colors.blue[800],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                    //   Text('ID: ${item.id}'
                                    //   ,                                      style: TextStyle(
                                    //     color: Colors.blue[800],
                                    //  //   fontSize: 18,
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    //   ),
                                      Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text('${item.incidentCriticalityLevel}',
                                      style: TextStyle(
                                      color:  item.incidentCriticalityLevel!.contains('minor') 
                                        ? Colors.green
                                        : (item.incidentCriticalityLevel!.contains('serious') ? Colors.orange : Colors.red),
                                        fontWeight: FontWeight.bold)
                                      ),),
                                      
                                    ],
                                  ),
                                ),
                                 Text('${item.status}', style: 
                                          TextStyle(
                                            color: Colors.blue[500],
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ),
                                SizedBox(height: 12),


                            
                            Row(
                              children: [
                                Icon(Icons.location_city,
                                color: Colors.blue,
                                size:20),
                                Text(' ${item.subLocationName}')
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer,
                                color: Colors.blue,
                                size:20),
                                Text(' ${item.dateTime?.split('T')[0]} | ${item.dateTime?.split('T')[1].replaceAll(RegExp(r'\.\d+Z$'), '')}')
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.edit,
                                color: Colors.blue,
                                size:20),
                                Expanded(
                                  child: Text(' ${item.description}',
                                  style: TextStyle(
                                  //  fontSize: 16
                                   ),),
                                )
                              ],
                            ),
                            //TODO: try image
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom:4.0),
                            //   child: Text('By: Faris Ejaz'),
                            // ),
                            //TODO: get user name dynamically
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                  FilledButton(
                                      onPressed: () {
                                        // Show a confirmation dialog before rejecting
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Delete?"),
                                              content: Text("Are you sure you want to delete this report?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(); // Close the dialog
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Handle the rejection logic here
                                                    // ...
                                                    Navigator.of(context).pop(); // Close the dialog
                                                  },
                                                  child: Text("Confirm"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                                        child: Text('Delete', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: FilledButton(
                                      onPressed: () async {
                                        //Add to Assigned form
                                    //  Fluttertoast.showToast(msg: '${item.id}');  
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
//                                        if (item != null && item.user_id != null) {   
                                          if(item.user_id != null)  {                                  
                                           await prefs.setString("this_user_id", (item.user_id!));
                                          }
                                          if (item.id != null) {                                       
                                           await prefs.setInt("user_report_id", (item.id!));
                                        }


              //                          if(prefs.getString('user_id') !=null && prefs.getInt('user_report_id') !=null) {
                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => AssignForm()),
                                          );
             //                           } 
                                        // print('user_id: ${prefs.getString('this_user_id')}');  
                                        // print('id: ${item.id}');  
                                        
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.yellowAccent),
                                      ),
                                      child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 0),
                                        child: Text('Assign', style: TextStyle(color: Colors.black)),
                                      ),
                                    ),
                                  )
                                  ],
                                ),

                                FilledButton(
                                  onPressed: () {
                                 //   final Future<File> img = convertMapToImageFile(item.image);
                 //                   print('${item.image}');
                                 //   Uint8List imageBytes = Uint8List.fromList((item.image['data'] as List).cast<int>());
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                               // Replace with your image
                           //                   Image.file(img as File, height: 200, width: 200, fit: BoxFit.fill,),
                                              displayImage(item.image!),
                                              // Image.asset('assets/palm_logo.png'),
                                              // Text('Picture of the incident'),
                                            
                                            ],
                                          ),
                                 //        child: displayImage(item.image['data']),
                                         
                                    //      print(img);
                                        );
                                      },
                                    );
                            //      print('${item.image}');

                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.attach_file, size: 16,),
                                        SizedBox(width: 5,),
                                        Text('View incident', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                )

                                  
                                ],
                            ),
                   ]),

                          ],),
                      )
                  );
                },
            
                );
            
          } else if(allReports.reports.isEmpty && allReports.isLoading) {
            return CircularProgressIndicator();
          }
            return Text('Failed to load reports');
  })
    );

  }  


}    


   

    
  