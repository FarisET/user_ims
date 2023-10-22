import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            Text(
              'Oops, something went wrong!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'The page you are looking for could not be found.',
              style: TextStyle(fontSize: 16),
            ),
            // SizedBox(
            //   height: 100,
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home_page');  
              },
              child: Text('Go to Home Page'),
            ),
          ],
        ),
      ),
    );
  }
}
