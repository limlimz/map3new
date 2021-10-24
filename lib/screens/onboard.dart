import 'package:flutter/material.dart';
import 'package:phone_verification/screens/profile.dart';

import 'login_screen.dart';
import 'map.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100),
            child: Image.asset(
              'assets/splash.png',
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: RichText(
              text: TextSpan(
                  text: '          By signing up for Map3n,you agree to our ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'terms of services',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    TextSpan(
                        text: ' learn  how we process your data in our  ',
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
                //Color c = const Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(6),
                color: Colors.blue,
                //Color myHexColor = Color(0xff123456)
                //Color color2 = _colorFromHex("#b74093");
              ),
              child: Text(
                'Get started',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "sign in",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ))
        ],
      ),
    );
  }
}
