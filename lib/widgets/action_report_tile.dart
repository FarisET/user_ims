// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

 
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_ims/Action%20Team%20Module/providers/all_action_reports_provider.dart';
import 'package:user_ims/User%20Module/services/ReportServices.dart';
import '../Action Team Module/providers/all_action_reports_approveal_provider.dart';
import '../models/action_report.dart';


class ActionReportTile extends StatefulWidget {
  const ActionReportTile({super.key});

  @override
  State<ActionReportTile> createState() => _ActionReportTileState();
}

class _ActionReportTileState extends State<ActionReportTile> {

  
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
// Widget displayImage(Map<String, dynamic> image) {
//   if (image != null && image.containsKey('data')) {
//     List<dynamic> data = image['data'];
//     if (data is List) {
//       // Convert the list of dynamic to a list of int
//       List<int> intList = data.cast<int>().toList();
//       Uint8List uint8List = Uint8List.fromList(intList);
//       return Image.memory(uint8List);
//     }
//   }

//   return Text("No image available");
// }

Widget displayImage(Uint8List imageData) {
  if (imageData != null) {
    return Image.memory(imageData);
  } else {
    return Text("No image available");
  }
}

//  void _generatePdfAndView(ActionReport item) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text('Incident Subtype: ${item.incident_subtype_description}'),
//             pw.Text('Reported By: ${item.reported_by}'),
//             pw.Text('Date and Time: ${item.date_time}'),
//             pw.Text('Report Description: ${item.report_description}'),
//             pw.Text('Resolution Description: ${item.resolution_description}'),
//             // Add other fields as needed
//           ],
//         ),
//       ),
//     );

    // Save the PDF to a temporary file
    // final Uint8List pdfBytes = await pdf.save();
    // final tempDir = await getTemporaryDirectory();
    // final tempFilePath = '${tempDir.path}/action_report.pdf';
    // final tempFile = File(tempFilePath);
    // await tempFile.writeAsBytes(pdfBytes);

    // Display the PDF using flutter_pdfview
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         child: PDFView(
  //           filePath: 'tempFilePath',
  //           autoSpacing: true,
  //           enableSwipe: true,
  //           pageSnap: true,
  //           swipeHorizontal: true,
  //           nightMode: false,
  //           onError: (e) {
  //             print(e);
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    Provider.of<ActionReportsProvider>(context, listen: false).fetchAllActionReports(context);   
    }





  @override
  Widget build(BuildContext context) {
   final approvalStatusProvider = Provider.of<ApprovalStatusProvider>(context);
   final fetchAllRepsProvider = Provider.of<ActionReportsProvider>(context, listen: false); 
    return Center(
      child: Consumer<ActionReportsProvider>(
        builder: (context, allReports,_) {
          if(allReports.reports.isNotEmpty) {
             return ListView.builder(
                itemCount: allReports.reports.length,
                itemBuilder: (context, i) {
                  var item = allReports.reports[i];
            
                  return Card(
                    color: item.status!.contains('approved') ? Colors.green[100]: Colors.red[100],
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
                                      Text(item.incident_subtype_description!,
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
                                      // Padding(
                                      // padding: const EdgeInsets.only(bottom:8.0),
                                      // child: Text('${item.}',
                                      // style: TextStyle(
                                      // color:  item.incidentCriticalityLevel!.contains('minor') 
                                      //   ? Colors.green
                                      //   : (item.incidentCriticalityLevel!.contains('serious') ? Colors.orange : Colors.red),
                                      //   fontWeight: FontWeight.bold)
                                      // ),),
                                      
                                    ],
                                  ),
                                ),

                            
                            // Row(
                            //   children: [
                            //     Icon(Icons.location_city,
                            //     color: Colors.blue,
                            //     size:20),
                            //     Text(' ${item.subLocationName}')
                            //   ],
                            // ),
                            Row(
                              children: [
                                Text('Reported By: ',
                                style: TextStyle(color:Colors.blue,
                                ),),
                                Expanded(
                                  child: Text(' ${item.reported_by}',
                                  style: TextStyle(
                                  //  fontSize: 16
                                   ),),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.timer,
                                color: Colors.blue,
                                size:20),
                                Text(' ${item.date_time?.split('T')[0]} | ${item.date_time?.split('T')[1].replaceAll(RegExp(r'\.\d+Z$'), '')}')
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.edit,
                                color: Colors.blue,
                                size:20),
                                Expanded(
                                  child: Text(' ${item.report_description}',
                                  style: TextStyle(
                                  //  fontSize: 16
                                   ),),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.check,
                                color: Colors.blue,
                                size:20),
                                Expanded(
                                  child: Text(' ${item.resolution_description}',
                                  style: TextStyle(
                                  //  fontSize: 16
                                  color: Colors.blue[700], fontWeight: FontWeight.bold
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                              content: Text("Are you sure you want to reject this report?"),
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
                                        child: Text('Reject', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),

                                    SizedBox(width: 4),

                                FilledButton(
                                  onPressed: () {
                                 //   final Future<File> img = convertMapToImageFile(item.image);
                 //                   print('${item.image}');
                                    Uint8List imageBytes = Uint8List.fromList((item.surrounding_image?['data'] as List).cast<int>());
                                  //  _generatePdfAndView(item);  
                                  Text('Report');                        //      print('${item.image}');

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
                                        Text('View Report', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: FilledButton(
                                    onPressed: () async {
                                      if (item.action_report_id != null && item.user_report_id != null) {
                                        ReportServices(context).postapprovedActionReport(item.user_report_id, item.action_report_id);
                                        approvalStatusProvider.updateStatus(item.status!);
                                        fetchAllRepsProvider.fetchAllActionReports(context);
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                         item.status!.contains('approved') ? Colors.greenAccent : Colors.yellowAccent,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                                      child: Text(
                                        item.status!.contains('approved') ? 'Approved' : 'Approve',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )   
                                ],
                                ),

                                  
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


   

    
  