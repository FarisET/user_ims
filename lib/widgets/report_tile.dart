// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:user_ims/services/ReportServices.dart';

import '../models/report.dart';
 
class ReportTile extends StatefulWidget {
  const ReportTile({super.key});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  late Future<List<Reports>> futureReports;
  

  @override
  void initState() {
    super.initState();
    futureReports = ReportServices(context).fetchReports();
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Reports>>(
        future: futureReports, 
        builder: (context, snapshot) {
          if(snapshot.hasData) {
             return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  var item = snapshot.data![i];
            
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(4),
                      side: BorderSide(
                        color: item.status?Colors.greenAccent:Colors.redAccent,
                        width:0.5)),                      clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                  padding: const EdgeInsets.only(bottom:8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(item.incidentType,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18
                                      ),),
                                      Text('id: ${item.id}'),
                                    ],
                                  ),
                                ),
                            
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom:4.0),
                            //   child: Text(item.incidentType,
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //   ),

                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:4.0),
                              child: Text('${item.location}, ${item.date}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:4.0),
                              child: Text('By: Faris Ejaz'),
                            ),
                            //TODO: get user name dynamically
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Last Modified:11, August 2023 at 11:09 am'),
                                item.status ? Text('Closed',
                                style: TextStyle(color: Colors.green),) :
                                Text('Open',
                                style: TextStyle(color: Colors.red),)
                                //TODO: change status color dynamically
                              ],
                          ),
                   ]),

                          
                      
                      
                      
                          ],),
                      )
                  );
                },
            
                );
            
          } else if(snapshot.hasError) {
            return Text('${snapshot.error}');
          }
            return CircularProgressIndicator();
  })
    );

  }  
     // padding: const EdgeInsets.only(bottom:8.0),
      //child: Container(
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(12),
      // //       border: Border(
      // //       left: BorderSide(
      // //     color: status!=null && status ? Colors.green : Colors.red,
      // //     width: 1.0, // Adjust the width as needed
      // //   ),
      // // ),
      //     ),

}    


   

    
  