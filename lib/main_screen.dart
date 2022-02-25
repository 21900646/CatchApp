// import 'package:align_ai/main.dart';
import 'dart:convert';

import 'package:catch_app/parking.dart';
import 'package:catch_app/pose_taxi/widgets/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'detectObject/camera.dart';
import 'main.dart';
import 'pushed_pageA.dart';

double lat = 0.0;
double lon = 0.0;

class MainScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  // final CameraDescription camera;

  // TakePictureScreen({
  //   required this.camera,
  // });
  MainScreen(this.cameras);

  static const String id = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String address_name = '';

  String building_name = '';

  List time_firebase = [];

  List location_firebase = [];

  @override
  void initState() {
    super.initState();
  }

  create(String audio) async{
    //list 가지고 오기

    FirebaseFirestore.instance.collection("parking")
        .doc("1")
        .get()
        .then((DocumentSnapshot ds){
      time_firebase = ds["time"];
      location_firebase = ds["result"];
      time_firebase.add(DateFormat('yyyy.MM.dd').format(DateTime.now()));
      location_firebase.add(Hive.box('picture').get('realtime_parking'));
    });

    if(location_firebase == []){
      time_firebase.add(DateFormat('yyyy.MM.dd').format(DateTime.now()));
      location_firebase.add(Hive.box('picture').get('realtime_parking'));
    }

    print(location_firebase);

    getJSONData().then(((_){
      try {
        FirebaseFirestore.instance
            .collection("parking")
            .doc("1")
            .set({
          "user" : "1",
          "real_time" : DateFormat('yyyy년 M월 dd일 HH시 mm분 ').format(DateTime.now()),
          "time" : time_firebase,
          "result" : location_firebase,
          "realtime_parking" : realtime_parking,
          //"time": DateFormat.yMMMd().add_jm().format(DateTime.now()),
          //"audio": audio,
          "location1": address_name,
          "location2": building_name,
          "lon": lon,
          "lat": lat,
          "url": ''
        });
      } catch (e) {
        print(e);
      }
      update_list();
    }));
  }

  update_list() async{
    try{
      location_firebase=realtime_parking as List;
      FirebaseFirestore.instance.collection("parking").doc(emailController.text).update({
        "time": time_firebase,
        "result": location_firebase,
      });
    } catch (e){
      print(e);
    }
  }

  getJSONData() async {
    print("here!!");
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    String lat2 = position.latitude.toString();
    String lon2 = position.longitude.toString();
    print(lat);
    print(lon);

    var url = Uri.parse("https://dapi.kakao.com/v2/local/geo/coord2address.json?x=${lon2}&y=${lat2}&input_coord=WGS84");
    var response = await http.get(url, headers: {"Authorization": "KakaoAK 18b7e90950a7fd11d072b2ed09f81e41"});

    String jsonData = response.body;
    print(jsonData);

    setState(() {
      lat = position.latitude;
      lon = position.longitude;
      address_name =
      jsonDecode(jsonData)["documents"][0]['road_address']['address_name'];
      building_name =
      jsonDecode(jsonData)["documents"][0]['road_address']['building_name'];
    });

    return "Successfull";
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state){
      case AppLifecycleState.inactive:
      //speak('주차를 어디에 하셨는지 사진으로 촬영해주세요 ');
        print("inactive");
        break;

      case AppLifecycleState.paused:
        create('');
        update_list();
        print("paused");
        break;

      case AppLifecycleState.detached:
        print("detached");
        break;
    }
  }

  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text('Align.AI'),
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          // Container(
          //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
          //   child: SizedBox(
          //     child: SearchBar('What pose do you wish to align?'),
          //   ),
          // ),
          Container(
            child: SizedBox(
              height: 150,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                scrollDirection: Axis.horizontal,
                children: [

                  //////팔 드는 것
                  Stack(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          color: Colors.white,
                          child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Image.asset('images/arm_press.PNG')),
                          onPressed: () =>{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  PushedPageA(cameras: widget.cameras, title: 'posenet'),
                              ),
                            )
                          },
                              // onSelectA(context: context, modelName: 'posenet'),
                        ),
                      ),
                    ],
                  ),

                  Stack(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          color: Colors.white,
                          child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Text('주차 ')),
                          onPressed: () =>{
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Parking(),
                              ),
                            )
                          },
                          // onSelectA(context: context, modelName: 'posenet'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void onSelectA({required BuildContext context, required String modelName}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PushedPageA(
        cameras: cameras,
        title: modelName,
      ),
    ),
  );
}
