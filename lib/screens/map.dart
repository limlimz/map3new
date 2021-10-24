import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phone_verification/model/user.dart';
import 'package:phone_verification/screens/profile.dart';
import 'package:phone_verification/service/service.dart';
import 'login_screen.dart';
import 'package:location/location.dart' as loc;

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  final loc.Location location = loc.Location();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = new TextEditingController();
  loc.LocationData currentPosition;
  UserModel userModel;


  getuserdata()async{

    userModel = await Database().getuserprofile();

  }
  void initState() {

    getuserdata();

    super.initState();
    // FirebaseAuth.instance.signOut();
  }
  //2
  static List<String> _listOfservices = <String>[
    "Plumbing",
    "Baby sitting",
    "Electrician",
    "Teacher",
    "Software engineer",
    "john",
    "jane",
    "jay",
    "johnte",
    "jayden",
    "john",
    "jane",
    "jay",
    "johnte",
    "jayden",
    "john",
    "jane",
    "jay",
    "johnte",
    "jayden",
  ];
  static List<String> _listOfwatu = <String>[
    "john",
    "deno",
    "jane",
    "pato",
    "jay",
    "johnte",
    "fred",
    "jayden",
  ];
  var _templistOfservices;
  var _templistOfwatu;
  final _auth = FirebaseAuth.instance;
  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.8206, 30.8025));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  bool _showBottomSheet1 = true;
  bool _showservice = true;

  @override
  Widget build(BuildContext context) {
    var _image;

    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80,
          title: Row(
            children: [
              InkWell(
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 100,
              ),
              InkWell(
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87,
                  ),
                  child: Text("Logout", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: SizedBox(
            height: 120.0,
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black87),
                  accountName: Text("Fred"),
                  accountEmail: Text("githumbi8fredgmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.grey.shade400,
                          child: ClipOval(
                            child: SizedBox(
                              width: 170,
                              height: 170,
                              child: _image == null
                                  ? Image.asset(
                                      'assets/placeholder.jpg',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 80,
                          right: 0,
                          child: FloatingActionButton(
                              backgroundColor: Colors.black12,
                              child: Icon(Icons.camera_alt),
                              mini: true,
                              onPressed: _onCameraClick),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Center(child: new Text("Hello userModel.FirstName")),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Conversations"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Receipts"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Request Board"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Help & FAQ"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Contact us"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("settings"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ),
        ),
        drawerEnableOpenDragGesture: false,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: _markers,
              mapType: _defaultMapType,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
            ),
            Container(
              margin: EdgeInsets.only(top: 80, right: 10),
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                      child: Icon(Icons.layers),
                      elevation: 5,
                      backgroundColor: Colors.teal[200],
                      onPressed: () {
                        _changeMapType();
                        print('Changing the Map Type');
                      }),
                ],
              ),
            ),
          ],
        ),
        bottomSheet: _showBottomSheet1
            ? BottomSheet(
                elevation: 10,
                backgroundColor: Colors.white,
                onClosing: () {
                  // Do something
                },
                builder: (BuildContext ctx) => DraggableScrollableSheet(
                    expand: false,
                    maxChildSize: 0.9,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        color: Colors.grey[200],
                        child: Column(children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          _showservice
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 58.0),
                                  child: Text(
                                      "Hello {Username} what are you looking for?"),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showservice = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_back_ios),
                                      Text(
                                          "Here are the {plumbs} in your area"),
                                    ],
                                  )),
                          SizedBox(
                            height: 10,
                          ),
                          _showservice
                              ?Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(children: <Widget>[
                                Expanded(
                                    child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  height: 60,
                                  child: Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 450,
                                      child: TextField(
                                          controller: textController,
                                          decoration: InputDecoration(
                                            hintText: "search a service .....",
                                            contentPadding: EdgeInsets.all(4),
                                            border: new OutlineInputBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      25.0),
                                              borderSide: new BorderSide(),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            //4
                                            setState(() {
                                              _templistOfservices =
                                                  _buildSearchList(value);
                                            });
                                          }),
                                    ),
                                  ),
                                ))
                              ]
                              ))
                          :Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(children: <Widget>[
                                Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                      ),
                                      height: 60,
                                      child: Center(
                                        child: SizedBox(
                                          height: 30,
                                          width: 450,
                                          child: TextField(
                                              controller: textController,
                                              decoration: InputDecoration(
                                                hintText: "search  service providers .....",
                                                contentPadding: EdgeInsets.all(4),
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                  new BorderRadius.circular(
                                                      25.0),
                                                  borderSide: new BorderSide(),
                                                ),
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              onChanged: (value) {
                                                //4
                                                setState(() {
                                                  _templistOfservices =
                                                      _buildSearchList(value);
                                                });
                                              }),
                                        ),
                                      ),
                                    ))
                              ]
                              )),
                          // IconButton(
                          //     icon: Icon(Icons.close),
                          //     color: Colors.black87,
                          //     onPressed: () {
                          //       setState(() {
                          //         textController.clear();
                          //         _templistOfservices.clear();
                          //       });
                          //     }),
                          _showservice
                              ? Expanded(
                                  child: ListView.builder(
                                      controller: scrollController,
                                      itemCount: (_templistOfservices != null &&
                                              _templistOfservices.length > 0)
                                          ? _templistOfservices.length
                                          : _listOfservices.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 90),
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                  leading: Container(
                                                      width: 100,
                                                      height: 65,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black87,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .only(
                                                            bottomRight:
                                                                const Radius
                                                                        .circular(
                                                                    50.0),
                                                            topRight: const Radius
                                                                .circular(50.0),
                                                            bottomLeft:
                                                                const Radius
                                                                        .circular(
                                                                    5.0),
                                                          )),
                                                      child: FlutterLogo(
                                                          size: 50.0)),
                                                  title: (_templistOfservices !=
                                                              null &&
                                                          _templistOfservices
                                                                  .length >
                                                              0)
                                                      ? _showBottomSheetWithSearch(
                                                          index,
                                                          _templistOfservices)
                                                      : _showBottomSheetWithSearch(
                                                          index,
                                                          _listOfservices),
                                                  onTap: () {
                                                    setState(() {
                                                      _showservice = false;
                                                    });

                                                    // Navigator.push(context,
                                                    //     MaterialPageRoute(builder: (context) => ListViewHome()));

                                                    // _scaffoldKey.currentState.showSnackBar(
                                                    //     SnackBar(
                                                    //         behavior: SnackBarBehavior.floating,
                                                    //         content: Text(
                                                    //             (_templistOfservices != null &&
                                                    //                     _templistOfservices
                                                    //                             .length >
                                                    //                         0)
                                                    //                 ? _templistOfservices[index]
                                                    //                 : _listOfservices[index])));
                                                  }),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : Expanded(
                                  child: ListView.separated(
                                      controller: scrollController,
                                      itemCount: (_templistOfwatu != null &&
                                              _templistOfwatu.length > 0)
                                          ? _templistOfwatu.length
                                          : _listOfwatu.length,
                                      separatorBuilder: (context, int) {
                                        return Divider(
                                          height: 1,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.white,
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                child:
                                                    Text(_listOfwatu[index][0]),
                                              ),
                                              title: Row(children: <Widget>[
                                                (_templistOfwatu != null &&
                                                        _templistOfwatu.length >
                                                            0)
                                                    ? _showBottomSheetWithSearch(
                                                        index, _templistOfwatu)
                                                    : _showBottomSheetWithSearch(
                                                        index, _listOfwatu),
                                                SizedBox(
                                                  width: 100,
                                                ),
                                                Expanded(
                                                    child: Container(
                                                        child:
                                                            Text("0.3 miles"))),
                                              ]),
                                              trailing: Icon(Icons
                                                  .arrow_forward_ios_rounded),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile()));

                                                // _scaffoldKey.currentState.showSnackBar(
                                                //     SnackBar(
                                                //         behavior: SnackBarBehavior.floating,
                                                //         content: Text(
                                                //             (_templistOfservices != null &&
                                                //                     _templistOfservices
                                                //                             .length >
                                                //                         0)
                                                //                 ? _templistOfservices[index]
                                                //                 : _listOfservices[index])));
                                              }),
                                        );
                                      }),
                                )
                        ]),
                      );
                    }))
            : null);
  }

  Widget _showBottomSheetWithSearch(int index, List<String> listOfservices) {
    return Text(
      listOfservices[index],
      style: TextStyle(
          color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  List<String> _buildSearchList(String userSearchTerm) {
    List<String> _searchList = [];

    for (int i = 0; i < _listOfservices.length; i++) {

      String name = _listOfservices[i];
      if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
        _searchList.add(_listOfservices[i]);
        return _searchList;
      }
      else {

          List<String> _searchList1= ['No  service'];
          return _searchList1;


      }
    }


  }

  Widget drawer() {
    return Drawer(
      elevation: 16.0,
      child: SizedBox(
        height: 120.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              accountName: Text("Limo"),
              accountEmail: Text("limopato254@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("image"),
              ),
              margin: EdgeInsets.zero,
            ),
            ListTile(
              title: new Text("Hello user"),
              leading: new Icon(Icons.person),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: new Text("Conversations"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: new Text("Receipts"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: new Text("Request Board"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: new Text("Help & FAQ"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: new Text("Contact us"),
              trailing: new Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: new Text("settings"),
              trailing: new Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
  }

  void _onCameraClick() {}


}
