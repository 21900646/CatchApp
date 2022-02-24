import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image/image.dart' as imglib;


class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  TakePictureScreen({
    required this.camera,
  });

  @override
  TakePictureScreenState createState() => TakePictureScreenState(camera: camera);
}


class TakePictureScreenState extends State<TakePictureScreen> {
  final CameraDescription camera;
  TakePictureScreenState({required this.camera});

  late CameraController _controller;
  late Future<void> _initializeControllerFuture ;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    if (widget.camera == null) {
      print('No camera is found');
    } else {
      // 카메라의 현재 출력물을 보여주기 위해 CameraController를 생성합니다.
      _controller = CameraController(
        // 이용 가능한 카메라 목록에서 특정 카메라를 가져옵니다.
        widget.camera,

        // 적용할 해상도를 지정합니다.
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller.initialize().then((_) async {
        if (!mounted) {
          return;
        }
        setState(() {});

        await _controller.lockCaptureOrientation();

        _controller.startImageStream((CameraImage img) async {

          // print("filePath ---------->");
          // print(filePath);

          //방법 1(cameraimage -> file --실패. 너무 시간이 오래 걸림. )
          //convertYUV420toImageColor(img);

          //방법 2(screenshot_controller 사용 --실패, cameraPreview가 촬영이 안됨.)
          // screenshotController
          //   .capture(delay: Duration(milliseconds: 10))
          //   .then((capturedImage) async{
          //     //이미지 확인
          //     ShowCapturedWidget(context, capturedImage!);
          //
          //     Image_upload(capturedImage!);
          // });

          //방법 3(flutter_navtive_screenshot --성공 but. 두 개 찍히고 카메라가 너무 느려짐)
          // String? path = await FlutterNativeScreenshot.takeScreenshot();
          // print(path);
          //
          // File imgFile = File(path!);
          // Image_upload2(imgFile);

          print("here!");
        });
    });
  }}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> create() async {
    try {
      await FirebaseFirestore.instance
          .collection("user_picture")
          .doc("1") //수정하기
          .set({
            //여기에 ocr 결과 넣기
            "ocr_result" : "",
          });
    } catch (e) {
      print(e);
    }
  }

  Image_upload(Uint8List list) async {
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(list);

    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('${DateTime.now()}.png')
        .putFile(file);

    String url = await snapshot.ref.getDownloadURL();
    await update(url);
  }

  Image_upload2(File file) async {
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('${DateTime.now()}.png')
        .putFile(file);

    String url = await snapshot.ref.getDownloadURL();
    await update(url);
  }

  update(String url) async {
    try {
      FirebaseFirestore.instance
          .collection("user_picture")
          .doc("1")
          .update({"url": url});
    } catch (e) {
      print(e);
    }
  }

  Future<void> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int? uvPixelStride = image.planes[1].bytesPerPixel;

      print("uvRowStride: " + uvRowStride.toString());
      print("uvPixelStride: " + uvPixelStride.toString());

      var img = imglib.Image(width, height);

      for(int x=0; x < width; x++) {
        for(int y=0; y < height; y++) {
          final int uvIndex = uvPixelStride! * (x/2).floor() + uvRowStride*(y/2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];

          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);

          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }
      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);

      print("png---------------------->");
      print(png);
      print("----------------------------");
      print(Uint8List.fromList(png));

      Image_upload(Uint8List.fromList(png));
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
  }

  //capture checking
  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  Future<void> caller() async {
    try {
      // 카메라 초기화가 완료됐는지 확인합니다.
      await _initializeControllerFuture;

      // _controller.startImageStream(
      //         (CameraImage image) async {
      //       print("here");
      //       create();
      //     }
      // );
      // path 패키지를 사용하여 이미지가 저장될 경로를 지정합니다.
      final path = join(
        // 본 예제에서는 임시 디렉토리에 이미지를 저장합니다. `path_provider`
        // 플러그인을 사용하여 임시 디렉토리를 찾으세요.
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      //

      //XFile picture = await _controller.takePicture();
      //picture.saveTo(path);
      //print(path);

      // // 사진 촬영을 시도하고 저장되는 경로를 로그로 남깁니다.
      // await _controller.takePicture(path);

      //사진을 촬영하면, 새로운 화면으로 넘어갑니다.
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => DisplayPictureScreen(imagePath: path),
      //     ),
      //   );
      // }
    }catch (e) {
      // 만약 에러가 발생하면, 콘솔에 에러 로그를 남깁니다.
      print("error is here!");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 방법 2
    // return Screenshot(
    //   controller: screenshotController,
    //   child:());
    return Scaffold(
      appBar: AppBar(title: Text('hud')),
      // 카메라 프리뷰를 보여주기 전에 컨트롤러 초기화를 기다려야 합니다. 컨트롤러 초기화가
      // 완료될 때까지 FutureBuilder를 사용하여 로딩 스피너를 보여주세요.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Future가 완료되면, 프리뷰를 보여줍니다.
            return CameraPreview(_controller);
          } else {
            // 그렇지 않다면, 진행 표시기를 보여줍니다.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Screenshot(
  //     controller: screenshotController,
  //     child: Container(
  //     ),
  //   );
  // }
}

// 사용자가 촬영한 사진을 보여주는 위젯
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  DisplayPictureScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // 이미지는 디바이스에 파일로 저장됩니다. 이미지를 보여주기 위해 주어진
      // 경로로 `Image.file`을 생성하세요.
      body: Image.file(File(imagePath)),
    );
  }
}
