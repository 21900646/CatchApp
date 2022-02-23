// import 'dart:async';
// import 'dart:io';
//
// import 'package:camera/camera.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'home.dart';
//
// //good
// Future<void> main() async {
//   // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); //firebase 초기화
//   await Permission.camera.request();
//   await Permission.bluetooth.request();
//   await Permission.microphone.request();
//   await Permission.location.request();
//   final cameras = await availableCameras();
//
//   // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
//   final firstCamera = cameras.first;
//
//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: home(
//         // 적절한 카메라를 TakePictureScreen 위젯에게 전달합니다.
//         camera: firstCamera,
//       ),
//     ),
//   );
// }

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'home_screen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //firebase 초기화
  await Permission.camera.request();
  await Permission.bluetooth.request();
  await Permission.microphone.request();
  await Permission.location.request();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
  //final firstCamera = cameras.first;

  runApp(
    CatchApp(cameras),
  );
}

class CatchApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  CatchApp(this.cameras);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(828, 1792),
      builder: () {
        return GetMaterialApp(
          // theme: AppTheme.regularTheme,
            title: 'Catch',
            debugShowCheckedModeBanner: false,
            home: HomeScreen(cameras),
            initialRoute: '/splash',
            routes: {

              // '/login': (context) => login(cameras),
              // '/splash': (context) => splash(cameras),
            }
        );
      },
    );
  }
}