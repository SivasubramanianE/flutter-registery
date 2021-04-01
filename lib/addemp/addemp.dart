import 'package:flutter/material.dart';
import 'package:registery/emplist/emplist.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddEmp extends StatefulWidget {
  @override
  _AddEmpForm createState() => _AddEmpForm();
}

class _AddEmpForm extends State<AddEmp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController reportingmanagerController = TextEditingController();
  TextEditingController datejoinController = TextEditingController();

  final GlobalKey<FormFieldState> _phoneFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _usernameFormKey = GlobalKey<FormFieldState>();
  bool checkAddorUpdate = false;
  String _chosenDepartment;
  String _chosenDesignation;
  var arr = []; 

  /// Defaults to today's date.
DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    nameController.dispose();
    phonenumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  validate(checkAddorUpdate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();  
     
    if(nameController.text != null  && phonenumberController.text != null && reportingmanagerController.text != '' && _chosenDepartment != null && _chosenDesignation !=null && datejoinController.text != null){
      Map<String, String> userdata = {
      "username": nameController.text,
      "phonenumber": phonenumberController.text,
      "reportingmanger": reportingmanagerController.text,
      "department": _chosenDepartment,
      "designation": _chosenDesignation,
      "joiningdate" : datejoinController.text,
    };

    if(checkAddorUpdate != false){
      var orgArr = json.decode(prefs.getString('userlist'));
      print('Orginal Arr' +orgArr.toString());
      orgArr
          .removeWhere((i) => i['username'] == nameController.text);
       
          print('Orginal data' +userdata.toString());
    orgArr.add(userdata);
    print('edit data' +orgArr.toString());
    prefs.setString('userlist', json.encode(orgArr));
    Navigator.of(context).pop();
    // Navigator.of(context).pushReplacementNamed('/emplist');

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmpList()));
    }else{
      //  GET THE ADDRESSES FROM SHARED PREFERENCE
     arr = prefs.getString('userlist') != null ? json.decode(prefs.getString('userlist')) : [];
    arr.add(userdata);
    prefs.setString('userlist', json.encode(arr));
    Navigator.of(context).pop();
    // Navigator.of(context).pushReplacementNamed('/emplist');

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EmpList()));
    }
    
    

  
    }else{
      final otpErrorSnackBar = SnackBar(content: Text("Fill All the fields Correctly"));
        ScaffoldMessenger.of(context).showSnackBar(otpErrorSnackBar);
    }
  
  // print(prefs.getString('userlist'));
    
  }

_selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: selectedDate,
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      datejoinController.text = ("${picked.toLocal()}".split(' ')[0]).toString();
    });
}
  
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
  if(arguments !=null ){
    nameController.text = arguments['username'];
    phonenumberController.text = arguments['phonenumber'];
    reportingmanagerController.text = arguments['reportingmanger'];
    _chosenDepartment = arguments['department'];
    _chosenDesignation = arguments['designation'];
    datejoinController.text = arguments['joiningdate'];
    checkAddorUpdate = arguments['update'];
  }
    
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      checkAddorUpdate == false ? 'Add ' : 'Update '  
                      ' Employee Details',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                    // EMPLOYEE NAME
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    key: _usernameFormKey,
                    enabled: !checkAddorUpdate,
                    onChanged: (value) {
                  setState(() {
                    _usernameFormKey.currentState.validate();
                  });
                  },
                    
                    validator: (value){
                    
                    if (value.isEmpty) {
                     return 'username is required';
                    }
                   return null;
                   },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: "User Name",
                    ),
                    
                  ),
                ),
                  
                    // DEPARTMENT
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 1),
                  ),
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenDepartment,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'HR',
                      'Technology',
                      'Account',
                      'Admin',
                      
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a Department",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenDepartment = value;
                      });
                    },
                  ),
                ),
                
                   // DESIGNATION
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: Colors.blue,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenDesignation,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Manager',
                      'Sr.Consultant',
                      'Jr. Consultant',
                      'Trainee',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a Designation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenDesignation = value;
                      });
                    },
                  ),
                ),
                
                    //CONTACT NUMBER
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                   keyboardType: TextInputType.number,
                    controller: phonenumberController,
                    key: _phoneFormKey,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact number',
                    ),
                
                  ),
                ),
                
                    //Joininf Date 
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                     controller: datejoinController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Joining Date',
                      
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ),


                    //REPORTING MANGER
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: reportingmanagerController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Manager name',
                    ),
                  ),
                ),
//                 
                
                Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // textStyle: ,
                      primary: Colors.blue,
                      ),
                      
                      child: Text(checkAddorUpdate == false ? 'ADD' : 'UPDATE'),
                      onPressed: () {
                        validate(checkAddorUpdate);
                      },
                    )),
              ],
            )));
  }
}
