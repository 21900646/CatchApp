import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';


class Parking extends StatefulWidget {
  const Parking({Key? key}) : super(key: key);

  @override
  _ParkingState createState() => _ParkingState();
}

class _ParkingState extends State<Parking> {

  double centerLon = 0;
  double centerLat = 0;
  String time_firebase = '';
  String location_firebase = '';

  double lat = 0.0;
  double lon = 0.0;

  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = [];


  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        onTap: () => print("Marker!"),
        position: LatLng(36.10234033683075, 129.38976770437253))
    );
  }


  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('parking').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        )
                    );
                  }
                  final parkings = snapshot.data?.docs;

                  List<Text> messageWidgets = [];
                  for (var parking in parkings!) {
                    Hive.box('picture').put('url', parking['url']);
                    //Hive.box('picture').put('audio', parking['audio']);
                    Hive.box('picture').put('real_time', parking['real_time']);
                    Hive.box('picture').put('location1', parking['location1']);
                    Hive.box('picture').put('location2', parking['location2']);
                    Hive.box('picture').put('realtime_parking', parking['realtime_parking']);
                    Hive.box('picture').put('lat', parking['lat']);
                    Hive.box('picture').put('lon', parking['lon']);
                    Hive.box('picture').put('result', parking['result']);
                    Hive.box('picture').put('time', parking['time']);
                  }
                  return Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.8),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(57.w, 137.h, 57.w, 0),
                        child: Column(
                            children:[
                              Container(
                                  child: Row(
                                    children: [
                                      // IconButton(icon: Icon(Icons.arrow_back, color: Colors.white), onPressed: () {
                                      //   Get.to(() => home(cameras));
                                      // },),
                                      Text(
                                        '주차정보',
                                        // style: textTheme.headline1!.copyWith(
                                        //   color: Colors.white,
                                        // ),
                                      ),
                                    ],
                                  )
                              ),

                              SizedBox(height: 91.h),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Column(
                                        children: [
                                          // if(Hive.box('picture').get('url')=="")
                                          //   Image.network(
                                          //     "https://cdn.ftoday.co.kr/news/photo/202109/223509_223162_2414.jpg",
                                          //     width: 332.w,
                                          //     height: 337.h,
                                          //     fit: BoxFit.fitHeight,
                                          //   ),
                                          // if(Hive.box('picture').get('url')!="")
                                          //   Image.network(
                                          //     Hive.box('picture').get('url'),
                                          //     width: 332.w,
                                          //     height: 337.h,
                                          //     fit: BoxFit.fitWidth,
                                          //   ),
                                        ]
                                    ),
                                  ),
                                  SizedBox(width: 50.w),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(17.w, 62.h, 17.w, 10.h),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    width: 332.w,
                                    height: 337.h,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   Hive.box('picture').get('audio'),
                                        //   style: textTheme.headline1!.copyWith(
                                        //     color: Colors.white,
                                        //     height: 1.2,
                                        //   ),
                                        //   maxLines:1,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),

                                        Text(
                                          Hive.box('picture').get('realtime_parking'),
                                          // style: textTheme.headline2!.copyWith(
                                          //   color: Colors.white,
                                          // ),
                                        ),
                                        SizedBox(height: 40.h),
                                        Text(
                                          Hive.box('picture').get('real_time'),
                                          style: TextStyle(
                                            fontSize: 22.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 13.h),
                                        Text(
                                          Hive.box('picture').get('location1') + " " + Hive.box('picture').get('location2'),
                                          style: textTheme.headline1!.copyWith(
                                              fontSize: 22.sp,
                                              color: Colors.white,
                                              height: 1.2
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40.h),
                              Container(
                                width: double.infinity,
                                height: 351.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child : GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                        bearing: 0,
                                        target: LatLng(36.10234033683075, 129.38976770437253),
                                        tilt: 0,
                                        zoom: 16
                                    ),
                                    markers: Set.from(_markers),
                                    onMapCreated: (GoogleMapController controller) {
                                      _controller.complete(controller);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 40.h),
                              Container(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(33.w, 23.h, 0, 23.h),
                                            width: double.infinity,
                                            height: 88.h,
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 42.w,
                                                    height: 42.h,
                                                    child: Icon(
                                                      Icons.folder_open,
                                                      color: Colors.white,
                                                    )
                                                ),
                                                SizedBox(width: 20.w),
                                                Text('주차내역',
                                                  style: textTheme.button!.copyWith(
                                                    color: Colors.white,
                                                  ),
                                                )

                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: List.generate(3,(index){
                                              return Container(
                                                width: double.infinity,
                                                height: 88.h,
                                                color: Colors.white,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(32.w, 37.h, 32.w, 0),
                                                  child: Column(
                                                    children: [
                                                      // if(Hive.box('picture').get('time').length > 3)
                                                      //   Text(
                                                      //     Hive.box('picture').get('time')[Hive.box('picture').get('time').length - index -1].toString() + " - " + Hive.box('picture').get('result')[Hive.box('picture').get('time').length - index -1].toString(),
                                                      //   ),
                                                      // if(Hive.box('picture').get('time').length <= 3)
                                                      //   Text(
                                                      //     Hive.box('picture').get('time')[index].toString() + " - " + Hive.box('picture').get('result')[index].toString(),
                                                      //   ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ),

                                  )
                              ),
                            ]
                        ),
                      ),

                    ],
                  );
                },
              ),

            ],
          )

      ),
    );
  }
}