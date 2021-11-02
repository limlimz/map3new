import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:intl_phone_field/intl_phone_field.dart';
import 'Auth.dart';
import 'map.dart';


enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;
  @override
  void  initState() {
    super.initState();
    FirebaseFirestore.instance.collection("user");

  }



  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null  ) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 8),
          child: Container(
            width: 50.0,
            height: 50.0,
            child: Icon(
              Icons.phone,
              color: Colors.grey,
              size: 40.0,
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
        SizedBox(
          height: 20,
        ),
        Text(
          " What's your phone \n number?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: new InputDecoration(
            hintText: '+1 00000',
          ),
        ),
        SizedBox(
          height: 10,
        ),
         // IntlPhoneField(
         //   controller: phoneController,
         // decoration: InputDecoration(
         //   //decoration for Input Field
         //    hintText: '000 0000',
         //  ),
         //  initialCountryCode: 'KE', //default contry code, NP for Nepal
         //  onChanged: (phone) {
         //     //when phone number country code is changed
         //     print(phone.completeNumber); //get complete number
         //    print(phone.countryCode); // get country code only
         //    print(phone.number); // only phone number
         //  },
         // ),

        Text(
            "Map3n will send you a text with verification code. \nMessage and data rates may apply"),
        Spacer(),

        InkWell(
          onTap: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(content: Text(verificationFailed.message)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 290,
              ),
              Container(
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
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        Text(
          "Enter the code we just texted you ",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: otpController,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Enter OTP",
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: ()  {


            PhoneAuthCredential phoneAuthCredential =
            PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpController.text);
            signInWithPhoneAuthCredential(phoneAuthCredential);
            print("Your jdsjkdfjdjkdsjdskjdsjkjdsdskjfdsjfdjfdsjfhdsjfjdjfdkjfjdsjdsjjdsfjdfdsjdjdjsjjdjduid is ${FirebaseAuth.instance.currentUser}");
             Auth();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
              ),
              Container(
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
            ],
          ),
        ),
        // FlatButton(
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        //   onPressed: () async {
        //     PhoneAuthCredential phoneAuthCredential =
        //         PhoneAuthProvider.credential(
        //             verificationId: verificationId,
        //             smsCode: otpController.text);
        //     signInWithPhoneAuthCredential(phoneAuthCredential);
        //     await Detail();
        //   },
        //   child: Text(
        //     "Next",
        //     style: TextStyle(fontSize: 12),
        //   ),
        //   color: Colors.white,
        //   textColor: Colors.black87,
        // ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Container(
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
