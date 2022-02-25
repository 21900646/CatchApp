// import 'package:align_ai/main.dart';
import 'package:catch_app/pose_taxi/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'main.dart';
import 'pushed_pageA.dart';

class MainScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  // final CameraDescription camera;

  // TakePictureScreen({
  //   required this.camera,
  // });
  MainScreen(this.cameras);

  static const String id = 'main_screen';
  @override
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
                                PushedPageA(cameras: cameras, title: 'posenet'),
                              ),
                            )
                          },
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
