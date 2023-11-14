// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'package:user_ims/widgets/action_report_tile.dart';

import '../../User Module/pages/login_page.dart';
import '../../User Module/services/UserServices.dart';
import '../../widgets/admin_report_tile.dart';
import '../../widgets/app_drawer.dart';
import '../providers/analytics_incident_reported_provider.dart';
import '../providers/analytics_incident_resolved_provider.dart';
import '../providers/fetch_countOfSubtypes_provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage>  with TickerProviderStateMixin {
  late final TabController _tabController;
  String? user_name;
  String? user_id;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
        WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<CountIncidentsResolvedProvider>(context, listen: false).getCountResolvedPostData();
      Provider.of<CountIncidentsReportedProvider>(context, listen: false).getCountReportedPostData();
      Provider.of<CountByIncidentSubTypesProviderClass>(context, listen: false).getcountByIncidentSubTypesPostData();

   
      });
    getUsername();
  }

  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  UserServices userServices = UserServices();


  void getUsername() {
    SharedPreferences.getInstance().then((prefs) async {
      user_name = await userServices.getName();
      setState(() {
        print('user_name: $user_name');
        user_id = prefs.getString("user_id");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final countResolvedProvider = Provider.of<CountIncidentsResolvedProvider>(context).totalIncidentsResolved;
    final countReportedProvider = Provider.of<CountIncidentsReportedProvider>(context).totalIncidentsReported;
    
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.7;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Dashboard'),
          actions: [
            SizedBox(
              height: 100,
child: FilledButton(
  child: Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
  onPressed: () {
    // Show a confirmation dialog before logging out
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
                // Perform logout actions here
                handleLogout(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  },
),
            ),
          ],
        ),
        drawer: AppDrawer(
          totalIncidentsReported:countReportedProvider !=null?countReportedProvider:'null value',
          totalIncidentsResolved: countResolvedProvider !=null?countResolvedProvider:'null value',
          incidentsBreakdown: {
            'Safety': 5,
            'Security': 4,
            'CodeOfConduct': 4,
            'maintenance': 6
          },
        ),
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //TODO: get user name dynamically in welcome
                            Text(
                              'Hi, $user_name!',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              intl.DateFormat.yMd().format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
      
                        //Profile
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
      
                    SizedBox(
                      height: 40,
                    ),
      
                  ],
                ),
              ),
      
                //Reports tab
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
            labelColor: Colors.white, // Color of the selected tab's label
              unselectedLabelColor: Colors.white, // Color of unselected tabs' labels
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold, // Style for the selected tab's label
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold, // Style for unselected tabs' labels
              ),
              indicator: BoxDecoration(
                // Decoration for the indicator below the selected tab
                color: Colors.blue[500],
                borderRadius: BorderRadius.circular(10), // You can adjust the shape
              ),            
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                text: 'User Reports',
              ),
              Tab(
                text: 'Action Team Reports',
              ),
            ],
                    ),
          ),
        SizedBox(height:10),

      Expanded(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: containerHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                           AdminReportTile(),
                           ActionReportTile() // Replace with Action Team Reports widget
                          ],
                        ),
                        
                      ),
                    ],
                  ),
              
              
            ),
          ),
        ),
          ],
        ),
      )
            ],
          ),
        ),
      ),
    );
  }

    void handleLogout(BuildContext context) async {
    UserServices userServices = UserServices();
    await userServices.logout();
  }
}