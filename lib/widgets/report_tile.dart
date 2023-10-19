// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:user_ims/widgets/reports_api.dart';

import '../models/report.dart';
 
class ReportTile extends StatefulWidget {
  const ReportTile({super.key});

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  
//   final String title;
//   final String incidentType;
//   final int id;
//   final String description;
//   final String location;
//   final String date;
//   final String risklevel;
//   final bool status;

//   const ReportTile({
//     Key? key,
//     required this.title,
//     required this.incidentType,
//     required this.id,
//     required this.description,
//     required this.location,
//     required this.date,
//     required this.risklevel,
//     required this.status
// }) : super(key: key);
  late Future<List<Reports>> futureReports; 

  @override
  void initState() {
    super.initState();
    futureReports = fetchReports();
  }




  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Reports>>(
        future: fetchReports(), 
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, i) {
                var item = snapshot.data![i];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(4),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ListTile(
                      title: Text(item.title),
                      subtitle:Text(item.description),
                      trailing: Text(item.id.toString()),
                      
                    )
                );
              },

              );
          } else if(snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
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


   

    
  