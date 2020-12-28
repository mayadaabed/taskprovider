import 'package:flutter/material.dart';
import './db_Helper.dart';
import 'flutterCourse/tabBarPage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _route() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TabBarPage();
    }));
  }

  @override
  void initState() {
    super.initState();
    _route();
  }

  @override
  Widget build(BuildContext context) {
    // DBHelper.dbHelper.selectAllTasks().then((value) => {
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //         return TabBarPage();
    //       }))
    //     });
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'Tasks',
          style: TextStyle(
              fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
