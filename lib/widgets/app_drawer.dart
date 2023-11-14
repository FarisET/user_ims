// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'count_by_incidentSubTypes.dart';

class AppDrawer extends StatelessWidget {
  final String totalIncidentsReported;
  final String totalIncidentsResolved;
  final Map<String, int> incidentsBreakdown;

  AppDrawer({
    required this.totalIncidentsReported,
    required this.totalIncidentsResolved,
    required this.incidentsBreakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Reporting Analytics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Card(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              leading:Icon(Icons.personal_injury, color: Colors.blue, size: 31,),
              title: Text('Total Incidents Reported'),
              subtitle: Text('$totalIncidentsReported'),
            ),
          ),
          Card(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              leading:Icon(Icons.check_box, color: Colors.green,size: 31,),
              title: Text('Total Incidents Resolved'),
              subtitle: Text('$totalIncidentsResolved'),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(4),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              leading:Icon(Icons.category, color: Colors.blue,size: 31,),
              title: Text('Types of Incidents Breakdown'),
              
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text('Safety Cases: ',style: TextStyle(color:Colors.blue,fontWeight:FontWeight.bold)),
                      Text('${incidentsBreakdown['Safety']}',style:TextStyle(color:Colors.black)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Security Cases: ',style: TextStyle(color:Colors.blue,fontWeight:FontWeight.bold)),
                      Text('${incidentsBreakdown['Security']}',style:TextStyle(color:Colors.black)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Code Violations: ',style: TextStyle(color:Colors.blue,fontWeight:FontWeight.bold)),
                      Text('${incidentsBreakdown['CodeOfConduct']}',style:TextStyle(color:Colors.black)),
                    ],
                  ),
                                    SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('Maintenance: ',style: TextStyle(color:Colors.blue,fontWeight:FontWeight.bold)),
                      Text('${incidentsBreakdown['maintenance']}',style:TextStyle(color:Colors.black)),
                    ],
                  ),

                ],
              ),
            ),
          ),

//          CountByIncidentSubTypeList()
        ],
      ),
    );
  }
}

