import 'dart:async';
import 'dart:core';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:phone_verification/model/user.dart';
import 'package:phone_verification/screens/profile.dart';
import 'package:phone_verification/service/service.dart';
import 'login_screen.dart';
import 'package:location/location.dart' as loc;

class Mapservice extends StatefulWidget {
  @override
  _MapserviceState createState() => _MapserviceState();
}

class _MapserviceState extends State<Mapservice> {
  GoogleMapController _controller;
  var Snapshot;
  final loc.Location location = loc.Location();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textController = new TextEditingController();
  loc.LocationData currentPosition;
  UserModel userModel;
  Position position;
  Set<Marker> markerList;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  getuserdata() async {
    userModel = await Database().getuserprofile();
    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      position = res;
    });
  }





  Future getpost() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection("providers")
        .doc()
        .get()
        .then((value) {
      if (value.exists) {
        print("data here Bwana ${value.data()}");
      }
    });
    return qn.docs;
  }




  void updatePosition() async {
//get user current location
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (position == null) {
      return;
    } else{
      FirebaseFirestore.instance.collection("location").doc(FirebaseAuth.instance.currentUser.uid).set({
        'location':GeoPoint(

          position.latitude,position.longitude
        )


      });

    }
//write place to initialise marker list as we have at least one marker now but  more markers will be needed in services app
    this.markerList = Set<Marker>();
//finally update state
    setState(() {
      this.position = position;this.markerList.add(Marker(position: LatLng(position.latitude, position.longitude), markerId: MarkerId("1")));
    });
  }

  Widget getgeo(){
    return StreamBuilder(
      stream:FirebaseFirestore.instance.collection("location").snapshots() ,
        builder: (context, snapshot){
        if (!snapshot.hasData) return Text(" markers loading");
        for (int i = 0; i < snapshot.data.length; ++i) {

        }
        }
    );
  }



  void initState() {
    getuserdata();
    super.initState();
    getCurrentLocation();
    updatePosition();
    getpost();
    populateClients();
// FirebaseAuth.instance.signOut();
  }

  final _auth = FirebaseAuth.instance;

  final double _zoom = 10;
  var serviceid;

  MapType _defaultMapType = MapType.normal;

  BitmapDescriptor pinLocationIcon;

  initMarker(request, requestId) {
    var p = request['location'];
    var markerIdVal = requestId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(p['latitude'], p['longitude  ']),
        infoWindow: InfoWindow(
          title: 'name',
        ));
    setState(() {
      markers[markerId] = marker;

    });
  }

  Future populateClients() async{
   return FirebaseFirestore.instance.collection("location").get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; ++i) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);

        }
      }
      return docs;
    });
  }


  // Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
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
  Widget build(BuildContext get) {
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
                  accountName: Text(" ${userModel.FirstName}"),
                  accountEmail: Text("${userModel.Email}"),
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
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title:
                      Center(child: new Text("Hello ${userModel.FirstName}")),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Conversations"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Receipts"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Request Board"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Help & FAQ"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  title: new Text("Contact us"),
                  trailing: new Icon(Icons.arrow_forward_ios),
                ),
                Divider(),
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
              markers: Set<Marker>.of(markers.values),
              mapType: _defaultMapType,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 20),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9.0),
                      topRight: Radius.circular(9.0)),
                ),
                elevation: 10,
                backgroundColor: Colors.grey,
                onClosing: () {
// Do something
                },
                builder: (BuildContext ctx) => DraggableScrollableSheet(
                    expand: false,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Column(children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        _showservice
                            ? Padding(
                                padding: const EdgeInsets.only(right: 58.0),
                                child: Text(
                                    "Hello ${userModel.FirstName} what are you looking for?"),
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
                                        "Here are the Autorepairers in your area"),
                                  ],
                                )),
                        _showservice
                            ? Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    height: 60,
                                    width: double.infinity,
                                    child: Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 500,
                                        child: TextField(
                                            controller: textController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "search a service .....",
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
                                                //  search will be here
                                              });
                                            }),
                                      ),
                                    ),
                                  ))
                                ]))
                            : Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
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
                                              hintText:
                                                  "search  service providers .....",
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
                                                // _templistOfservices =
                                                //     _buildSearchList(value);
                                              });
                                            }),
                                      ),
                                    ),
                                  ))
                                ])),
                        _showservice
                            ? Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('services')
                                        .snapshots(),
                                    builder: (
                                      context,
                                      snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.black,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.teal),
                                          ),
                                        );
                                      else
                                        return ListView.separated(
                                            controller: scrollController,
                                            itemCount: snapshot.data.docs.length,
                                            separatorBuilder: (context, int) {
                                              return Divider(
                                                height: 1,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return Card(
                                                elevation: 10,
                                                margin: EdgeInsets.zero,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  color: Colors.white,
                                                  child: ListTile(
                                                      contentPadding: EdgeInsets.all(0),
                                                      title: new Text(
                                                        snapshot
                                                            .data.docs[index]
                                                            .data()["name"],
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          _showservice = false;
                                                          serviceid =
                                                              snapshot.data
                                                                  .docs[index].id;
                                                          print(serviceid);
                                                          print(snapshot
                                                              .data.docs[index]
                                                              .toString());
                                                        });
                                                      }),
                                                ),
                                              );
                                            });
                                    }),
                              )
                            : Expanded(
                                child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('service_providers')
                                    .where("services", arrayContainsAny: [serviceid])
                                        .snapshots(),
                                    builder: (
                                      context,
                                      snapshot,
                                    ) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.black,
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(Colors.teal),
                                          ),
                                        );
                                      else
                                        return ListView.separated(
                                            controller: scrollController,
                                            itemCount: snapshot.data.docs.length,
                                            separatorBuilder: (context, int) {
                                              return Divider(
                                                height: 1,
                                              );
                                            },
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: Colors.white,
                                                child: ListTile(
                                                    title: Row(
                                                      children: [
                                                        new Text(
                                                          snapshot.data.docs[index]['name'],
                                                        ),
                                                        SizedBox(width: 150,),
                                                        new Text(
                                                          snapshot.data.docs[index]['description'],
                                                        ),
                                                      ],
                                                    ),
                                                    // leading: new Text(
                                                    //   providersIndex[
                                                    //   'providers']
                                                    //   [index]['icon'],
                                                    // ),
                                                    // trailing:new Text(
                                                    //   providersIndex[
                                                    //   'providers']
                                                    //   [index]['image'],
                                                    // ),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Profile()));
                                                    }),
                                              );
                                            });
                                    }),
                              )
                      ]);
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
}
