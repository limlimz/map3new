import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';

import 'chats.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              color: Colors.blueGrey[300],
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: new Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Results",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 220,
                  ),
                  Container(
                    width: 20.0,
                    height: 20.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 15.0,
                      ),
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
          ),
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 4,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                top: 0,
              ),
              child: GFAvatar(
                  size: 80,
                  child: Image.asset(
                    'assets/placeholder.jpg',
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 120.0,
                  ),
                  shape: GFAvatarShape.standard),
            ),
          ),
          Positioned(
              top: 180,
              child: Column(
                children: [
                  Text("username"),
                  Text("ratings here"),
                ],
              )),
          Positioned(
              top: 240,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Insert service cate.."),
                  SizedBox(
                    width: 130,
                  ),
                  Text("ratings here"),
                ],
              )),
          Positioned(
              top: 280,
              child: Padding(
                padding: const EdgeInsets.only(right: 208.0),
                child: Text("Insert service cate.."),
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Text(
                  "A software engineer is a person who applies the principles of software"
                  " engineering to design, develop, maintain, test, and evaluate computer software. "
                  "The term programmer is sometimes used as a synonym,"
                  " but may also lack connotations of engineering education or skills."),
            ),
          ),
          Positioned(
            bottom: 20,
            child: InkWell(
              onTap: () {

              },
              child: Container(
                height: 40,
                width: 200,
                child: Center(
                    child: Text(
                  ' send message',
                  style: TextStyle(color: Colors.blue),
                )),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent[50],
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
