import 'package:flutter/material.dart';

import 'login/login.dart' as loginPage;
import 'addemp/addemp.dart' as addEmp;
import 'emplist/emplist.dart' as emplist;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return FutureBuilder(
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          //   return MaterialApp(
          //     home: Scaffold(
          //       body: Center(
          //         child: CircularProgressIndicator(),
          //       ),
          //     ),
          //   );
          // } 
          // else {
            
            return Center(
              child: MaterialApp(
                home: loginPage.LoginIn(),
                routes: <String, WidgetBuilder>{
                  "/login": (BuildContext context) => new loginPage.LoginIn(),
                  "/emplist": (BuildContext context) =>
                      new emplist.EmpList(),
                  "/addemp": (BuildContext context) =>
                      new addEmp.AddEmp(),
                  
                },
              ),
            );
          // }
        });
  }
}
