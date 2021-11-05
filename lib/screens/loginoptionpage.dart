import 'package:flutter/material.dart';
import 'package:phone_verification/screens/profile.dart';

import 'login_screen.dart';
import 'HomesScreen.dart';

class Option extends StatefulWidget {
  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // SizedBox(
          //   height: 250,
          // ),
          Spacer(),
          Image.asset(
            'assets/splash.png',
          ),
           Spacer(),
          Center(
            child: RichText(
              textAlign: TextAlign.center,


              text: TextSpan(
                  text: '             By signing up for Map3n,you agreeto our ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'terms of services.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: ' Learn  how we process your data in our  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'privacy\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: '          ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'policy ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    TextSpan(
                      text: 'cookies policy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ]),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Color(0xFFfee5a2),

              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                  ),
                  Icon(Icons.speaker_phone_rounded),
                  Text(
                    'Sign in with Apple',
                    style: TextStyle(color: Colors.grey[900], fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //Color c = const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(9),
                color: Color(0xFF9aa096),
                //Color myHexColor = Color(0xff123456)
                //Color color2 = _colorFromHex("#b74093");
              ),
              child: Text(
                'Sign in with facebook',
                style: TextStyle(color: Colors.grey[900], fontSize: 17),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
              width: 300,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //Color c = const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(9),
                color: Color(0xFFa1b985),
                //Color myHexColor = Color(0xff123456)
                //Color color2 = _colorFromHex("#b74093");
              ),
              child: Text(
                'Sign in with Phone number',
                style: TextStyle(color: Colors.grey[900], fontSize: 17),
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
