import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_verification/screens/map.dart';
import 'package:phone_verification/screens/profile.dart';

File _image;

class Detail extends StatefulWidget {
  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<Detail> {

  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _emailAddress = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _namelast = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String name, email, password, confirmPassword;
  FirebaseFirestore firestore = FirebaseFirestore.instance;




  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("user");

  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: Form(
            key: _key,
            autovalidateMode: _validate,
            child: formUI(),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 90,
        ),
        Text(
          " Confirm your information",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 70,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                height: 50,
                child: Center(
                  child: TextFormField(
                      controller: _name,
                      validator: validateName,
                      onSaved: (val) => name = val,
                      maxLines: null,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        hintText: 'First Name',
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                height: 50,
                child: Center(
                  child: TextFormField(
                      controller: _namelast,
                      validator: validateName,
                      maxLines: null,
                      onSaved: (val) => name = val,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        isCollapsed: true,
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        hintText: 'Last Name',
                      )),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          height: 50,
          child: Center(
            child: TextFormField(
                controller: _emailAddress,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: validateEmail,
                onSaved: (val) => email = val,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: 'Email Address',
                )),
          ),
        ),
        SizedBox(
          height: 250,
        ),

         Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 290,
              ),
              InkWell(
                onTap: _signUp,
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

      ],
    );
  }

  _signUp() async {
    if (_key.currentState?.validate() ?? false) {
      _key.currentState.save();
      await User();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Map()));
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  Future<void> User() async {
    await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).set({
      'First Name': _name.text,
      'Last Name': _namelast.text,
      'Email': _emailAddress.text,
    });
  }

  // Database().createuserInfo(_name.text, _namelast.text,_emailAddress.text,).then((value){
  //
  // print("value value"+value.toString());
  //
  // //we have a reponse from registraion funtion, so we need to set the loading to false and refresh the page by useing set state
  // loading = false;
  //
  // //we check if the respose is true, meaning the registration is successful
  // if(value == true){
  // Navigator.push(context,
  // MaterialPageRoute(builder: (context) => Home()));
  // }else{
  // //if the registraion is not successful, then we give user a message that registration has faile;
  // _message = "user registration failed";
  //
  // }
  //
  // setState(() {
  //
  // });
  // }



  @override
  void dispose() {
    _passwordController.dispose();
    _image = null;
    super.dispose();

  }





  String validatePassword(String value) {
    if ((value?.length ?? 0) < 6)
      return 'Password must be more than 5 characters';
    else
      return null;
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "Name is required";
    } else if (!regExp.hasMatch(value ?? '')) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value ?? ''))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Password doesn\'t match';
    } else if (confirmPassword?.length == 0) {
      return 'Confirm password is required';
    } else {
      return null;
    }
  }
}
