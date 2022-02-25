import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:turning/theme/app_colors.dart';
import 'camera_view.dart';
import 'face_detector_painter.dart';
// import 'home.dart';
// import 'login.dart';
// import 'main.dart';
import 'face_detector_painter.dart';
import 'dart:math' as math;

bool drown=false;

class FaceDetectorView2 extends StatefulWidget {
  @override
  _FaceDetectorView2State createState() => _FaceDetectorView2State();
}

class _FaceDetectorView2State extends State<FaceDetectorView2> {
  FaceDetector faceDetector =
  GoogleMlKit.vision.faceDetector(FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
  ));

  bool isBusy = false;
  CustomPaint? customPaint;

  Timer? _timer;
  Stopwatch watch = Stopwatch();
  bool startStop = true;
  double elapsedTime = 0.0;

  updateTime(Timer timer) {
    if (watch.isRunning) {
      setState(() {
        print("startstop Inside=$startStop");
        elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
      });
    }
  }

  startOrStop() {
    if(startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    print("start watch");
    watch.start();
    setState(() {
      setTime();
      //_timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
    print(elapsedTime);
    return Container();
  }

  stopWatch() {
    print("stop watch");
    watch.stop();
    setState(() {
      startStop = true;
      elapsedTime = 0;
    });
    print(elapsedTime);
    watch.reset();
    return Container();
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {

    double hundreds = (milliseconds / 1000);
    print("hundreds ==> {$hundreds}");
    double result = elapsedTime + hundreds;
    print("result ==> {$result}");
    //double hundreds = (milliseconds / 1000);

    return result;
  }

  @override
  void dispose() {
    _timer?.cancel();
    faceDetector.close();
    super.dispose();
  }

  printTime(String elapsedTime){
    print(elapsedTime);
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(
      children: [
        CameraView(
          title: '운전자 졸음 인식',
          customPaint: customPaint,
          onImage: (inputImage) {
            processImage(inputImage);
          },
          initialDirection: CameraLensDirection.front,
        ),
        Positioned(
          bottom: 448.h,
          left: 635.w,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withOpacity(0.4),
            ),
            width: 193.w,
            height: 891.h,
            child: Column(
              children: [
                SizedBox(
                  height: 54.h,
                ),

                //0
                SizedBox(
                  height: 124.h,
                  width: 124.h,
                  child: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 124.h,
                          width: 124.h,
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                                  return Colors.black.withOpacity(0.3);
                                }),
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    color: Colors.black,
                                    //AppColors.onPrimary,
                                    width: 3.w,
                                  ),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30.h),
                                        side: BorderSide(
                                            color: Colors.black,
                                            //AppColors.onPrimary
                                            )))),
                            onPressed: () {
                              setState(() {});
                            },
                            child: Image.asset('assets/icons/스쿨존.png',
                                color: Colors.black
                                //true ? Colors.white.withOpacity(0.5) : AppColors.primary[800]
                          ),
                          ),
                        )
                      ],
                    ),

                  ),
                ),
                SizedBox(
                  height: 42.h,
                ),

                //1
                SizedBox(
                  height: 124.h,
                  width: 124.h,
                  child: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: Row(
                      children: [
                          SizedBox(
                            height: 124.h,
                            width: 124.h,
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                    return Colors.black.withOpacity(0.3);
                                  }),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      color: Colors.black,
                                      //AppColors.onPrimary,
                                      width: 3.w,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.h),
                                          side: BorderSide(
                                              color:
                                              Colors.black
                                              //AppColors.onPrimary
                                          )))),
                              onPressed: () {
                                setState(() {});
                              },
                              child: Image.asset('assets/icons/구급차.png',
                                  color:
                                  Colors.black
                                  //true ? Colors.white.withOpacity(0.5) : AppColors.primary[800]
                              ),
                                  //Colors.black
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 42.h),


                //2
                SizedBox(
                  height: 124.h,
                  width: 124.h,
                  child: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: Row(
                      children: [
                          SizedBox(
                            height: 124.h,
                            width: 124.h,
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                    return Colors.black.withOpacity(0.3);
                                  }),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      color:
                                      //AppColors.onPrimary,
                                      Colors.black,
                                      width: 3.w,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.h),
                                          side: BorderSide(
                                              color:
                                              //AppColors.onPrimary
                                              Colors.black,
                                          )))),
                              onPressed: () {
                                setState(() {});
                              },
                              child: Image.asset('assets/icons/장애물2.png',
                                  color:
                                  Colors.black
                                  //true ? Colors.white.withOpacity(0.5) : AppColors.primary[800]
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 42.h),

                //3
                SizedBox(
                  height: 124.h,
                  width: 124.h,
                  child: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: Row(
                      children: [
                        // if(func[4] == true)
                          SizedBox(
                            height: 124.h,
                            width: 124.h,
                            child: ElevatedButton(
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style!
                                  .copyWith(
                                  backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                    return elapsedTime > 2 && drown==true?
                                    Colors.red: Colors.white.withOpacity(0.0);
                                  }),
                                  side: MaterialStateProperty.all(
                                    BorderSide(
                                      color:Colors.black,
                                      //AppColors.onPrimary,
                                      width: 3.w,
                                    ),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.h),
                                          side: BorderSide(
                                              color:
                                              //AppColors.onPrimary
                                              Colors.black,
                                          )))),
                              onPressed: () {
                                setState(() {});
                              },
                              child: Image.asset('assets/icons/졸음.png',
                                  color: Colors.white),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 42.h),

                //4
                SizedBox(
                  height: 124.h,
                  width: 124.h,
                  child: Transform.rotate(
                    angle: 90 * math.pi / 180,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 124.h,
                          width: 124.h,
                          child: ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                                  return Colors.black.withOpacity(0.3);
                                }),
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    color:
                                    //AppColors.onPrimary,
                                    Colors.black,
                                    width: 3.w,
                                  ),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30.h),
                                        side: BorderSide(
                                            color:Colors.black
                                            //AppColors.onPrimary
                                            )))),
                            onPressed: () {
                              setState(() {});
                            },
                            child: Image.asset('assets/icons/휴대폰.png',
                                color:Colors.black)
                                //true ? Colors.white.withOpacity(0.5) : AppColors.primary[800]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //     bottom:55.h,
        //     right:55.w,
        //
        //     child: IconButton(
        //       iconSize: 50.w,
        //       icon: Icon(Icons.close),
        //       onPressed: (){
        //         Get.offAll(() => home(cameras));
        //       },
        //     )
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (drown==true)
              startWatch(),
            if (elapsedTime > 2 && drown==true)
              Text(
                //"${emailController.text}"+"님께서\n"
                    "졸고 있는 것이 발견되었습니다.",
                style: textTheme.headline1!.copyWith(
                    color: Colors.black,
                    //AppColors.onSurface[87],
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              // Text('졸지마!',
              //   style:TextStyle(fontSize: 100),
              // ),
            if (drown==false) stopWatch(),
          ],
        ),
      ],
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    print('Found ${faces.length} faces');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = FaceDetectorPainter(
          faces,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
