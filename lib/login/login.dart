import 'package:flutter/material.dart';


class LoginIn extends StatefulWidget {
  @override
  _LoginInForm createState() => _LoginInForm();
}

class _LoginInForm extends State<LoginIn> {
 
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormFieldState> _emailFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordFormKey = GlobalKey<FormFieldState>();

  
  String _usernameError;
  String _passwordError;


  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

     validate(){
          print(passwordController.text + nameController.text);
        if(passwordController.text != '' && nameController.text !=''){
             Navigator.of(context).pushNamed('/emplist');
        }else{
          final otpErrorSnackBar = SnackBar(content: Text("Fill All the fields Correctly"));
        ScaffoldMessenger.of(context).showSnackBar(otpErrorSnackBar);
        }
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Employee Register App',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    )),
                 Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    key: _emailFormKey,
                    onChanged: (value) {
                  setState(() {
                    _emailFormKey.currentState.validate();
                  });
                  },
                    
                    validator: (value){
                    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty) {
                     return 'Email is required';
                    }
                  
                if (!(regex.hasMatch(value))){
                  return "Invalid Email";
                }
                   
                  
                   return null;
                   },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email ID',
                      hintText: "Email ID",
                      errorText: _usernameError,
                    ),
                    
                  ),
                ),
                  
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: _passwordError,
                    ),
                      key: _passwordFormKey,
                    onChanged: (value) {
                  setState(() {
                    _passwordFormKey.currentState.validate();
                  });
                  },
                    
                    validator: (value){
                    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,15}$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty) {
                     return 'Password is required';
                    }
                     if (value.length > 15 ||
                      (value.length >= 1 && value.length < 8)) {
                    return 'Password charather must be 8 to 15 letters';
                  }
                  
                if (!(regex.hasMatch(value))){
                  return "Invalid Password";
                }
                   
                  
                   return null;
                   },
                  ),
                ),
                Container(
                  height: 50,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        validate();
                      },
                    )),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text('Does not have account?'),
                      // ignore: deprecated_member_use
                      FlatButton(
                        textColor: Colors.blue,
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
