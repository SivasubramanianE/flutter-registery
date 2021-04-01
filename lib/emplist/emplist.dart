import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpList extends StatefulWidget {
  @override
  _EmpListui createState() => _EmpListui();
}

class _EmpListui extends State<EmpList> {
  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userlist') != null){
      setState(() {
        data = json.decode(prefs.getString('userlist'));
            });
    
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Employee List"), backgroundColor: Colors.blue),
        body: Container(
            child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    if (data.length > 0)
                      Container(
                          height: mediaQuery.size.height * 0.80,
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 0, top: 5),
                                  child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey[350],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[350],
                                            offset: Offset(0.0, 1.0),
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Container(
                                          //   child: Text(
                                          //         data[index]['username'],
                                          //     style: TextStyle(
                                          //         fontSize: 20,
                                          //         fontWeight: FontWeight.w800),
                                          //   ),
                                          //   margin: EdgeInsets.only(bottom: 10),
                                          // ),

                                          Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    child: Text(
                                                      data[index]['username'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        bottom: 10),
                                                  ),
                                                  new GestureDetector(
                                                      onTap: () {
                                                        // Navigator.of(context).pop();
                                                        Navigator.of(context)
                                                            .pushReplacementNamed(
                                                                '/addemp',
                                                                arguments: {
                                                              "username": data[
                                                                      index]
                                                                  ['username'],
                                                              "phonenumber": data[
                                                                      index][
                                                                  'phonenumber'],
                                                              "reportingmanger":
                                                                  data[index][
                                                                      'reportingmanger'],
                                                              "department": data[
                                                                      index][
                                                                  'department'],
                                                              "designation": data[
                                                                      index][
                                                                  'designation'],
                                                              "joiningdate": data[
                                                                      index][
                                                                  'joiningdate'],
                                                               "update": true
                                                            });
                                                      },
                                                      child: new Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .red[400]),
                                                          child: Text("Edit",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)))),
                                                ]),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      "Department :" +
                                                          data[index]
                                                              ['department'],
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      "Contact No. :" +
                                                          data[index][
                                                                  'phonenumber']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              })),
                    if (data.length == 0)
                      Container(
                        height: mediaQuery.size.height * 0.80,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox,
                                color: Colors.grey[400], size: 100),
                            Text(
                              "No Employee Found",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 25,
                              ),
                            ),
                          ],
                        )),
                      ),
                    Container(
                      height: mediaQuery.size.height * 0.080,
                      decoration: BoxDecoration(
                        // color: _themeColor,
                        color: Color(0xFF0E3311).withOpacity(0.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // .only(
                        //   topLeft: Radius.circular(_containerRadius),
                        //   topRight: Radius.circular(_containerRadius),
                        // ),
                      ),
                      width: mediaQuery.size.width * 1,
                      padding: const EdgeInsets.all(10),
                      child: ButtonTheme(
                        height: 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            textStyle: TextStyle(color: Colors.white),
                            // color: Color.fromRGBO(2, 99, 152, 1),
                            primary: Color.fromRGBO(2, 99, 152, 1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Add Employee',
                                  style: TextStyle(fontSize: 24)),
                            ],
                          ),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed('/addemp');
                            // FocusScope.of(context).unfocus();
                            // _cart();
                          },
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
