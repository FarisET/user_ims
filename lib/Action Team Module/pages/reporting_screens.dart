// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user_ims/Action%20Team%20Module/pages/action_report_1.dart';
import 'package:user_ims/Action%20Team%20Module/pages/action_report_2.dart';
import 'package:user_ims/Action%20Team%20Module/pages/action_team_home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ReportingScreens extends StatefulWidget {
  const ReportingScreens({super.key});

  @override
  State<ReportingScreens> createState() => _ReportingScreensState();
}

class _ReportingScreensState extends State<ReportingScreens> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          PageView(
          onPageChanged: (index) { 
            setState(() {
            onLastPage = (index == 1);
          });
          },
          controller: _controller,
          children: [
            ActionReport1(),
            ActionReport2()
          ],
        ),
        
        Container(
          alignment: Alignment(0,0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

                GestureDetector(
                onTap: () {
                  _controller.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back_ios,
                    size: 16,),
                    Text(' Back',
                      style: TextStyle(
                      fontSize: 14,  
                      fontWeight: FontWeight.w800,
                        
                        
                        
                        )
                        ),
                  ],
                ),
              ),              


              SmoothPageIndicator(controller: _controller, count: 2),

              onLastPage?  
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ActionTeamHomePage()), 
                  );
                },
                child: Text('Sumbit',
                style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14, 
                  )
                  ),
              ) :  GestureDetector(
                onTap: () {
                  _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                child: Row(
                  children: const [
                    Text('Next ',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14, 
                      )
                      ),
                  
                    Icon(Icons.arrow_forward_ios,
                    size: 16,),
                  ],
                ),
              )

            ],
          ))  
        ]
      )
    );
  }
}