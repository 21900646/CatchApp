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
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: const Text(
              'AlignAI',
              style: TextStyle(
                color: Color(0xFFFE7C7C),
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: const Text(
              'Master Your Body Alignment',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
          ),
          SizedBox(height: 10),
          Image.asset('images/align.PNG'),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: SizedBox(
              child: SearchBar('What pose do you wish to align?'),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              'Strength Alignment',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
          ),
          Container(
            child: SizedBox(
              height: 150,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                scrollDirection: Axis.horizontal,
                children: [
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/crunch.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),

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
                              // onSelectA(context: context, modelName: 'posenet'),
                        ),
                      ),
                    ],
                  ),

                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/push_up.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                              child: Image.asset('images/squat.PNG')),
                          onPressed: () =>{},
                              //onSelectS(context: context, modelName: 'posenet'),
                        ),
                      ),
                    ],
                  ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/plank.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/lunge_squat.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              'Yoga Alignment',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
          ),
          Container(
            child: SizedBox(
              height: 100,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                scrollDirection: Axis.horizontal,
                children: [
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/yoga1.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //////중요
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/yoga4.PNG')),
                  //         onPressed: () =>{}
                  //             //onSelectY(context: context, modelName: 'posenet'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/yoga2.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/yoga3.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       width: 100,
                  //       height: 100,
                  //       padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //       child: RaisedButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(18.0)),
                  //         color: Colors.white,
                  //         child: Container(
                  //             padding: EdgeInsets.all(10.0),
                  //             child: Image.asset('images/yoga5.PNG')),
                  //         onPressed: () {
                  //           print('hello');
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          // Container(
          //   child: RaisedButton(
          //     child: Text('Pose Estimation'),
          //     onPressed: () =>
          //         onSelectY(context: context, modelName: 'posenet'),
          //   ),
          // ),
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
//
// void onSelectS({required BuildContext context, required String modelName}) async {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PushedPageS(
//         cameras: cameras,
//         title: modelName,
//       ),
//     ),
//   );
// }

// void onSelectY({required BuildContext context, required String modelName}) async {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PushedPageY(
//         cameras: cameras,
//         title: modelName,
//       ),
//     ),
//   );
// }
