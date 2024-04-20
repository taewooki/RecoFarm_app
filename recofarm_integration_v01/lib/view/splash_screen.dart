import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_recofarm_app/view/login.dart';

import 'home.dart';
/*
  * Description : Splash screen  
  * Date        : 2024.04.20
  * Author      : pdg 
  * Updates     : 
  *   2024.04.20 by pdg
        - logo image plotting ( farmer logo )
        - splash image 1, 2 삽입 

*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //2 초에 한번씩 페이지가 넘어가는 스플래쉬 제작
      int? nextpage = pageController.page?.toInt();
      if (nextpage == null) {
        return;
      }
      if (nextpage == 2) {
        // splash 화면이 다되면 메인으로 넘어감.
        Get.to(Home(), 
        transition: Transition.fade,
        curve:Curves.bounceOut ,
        duration: Duration(seconds: 2),
        );
        _timer.cancel();
      } else {
        nextpage++;
      }
      pageController.animateToPage(
        nextpage,
        duration:  Duration(milliseconds: 700),
        curve: Curves.bounceOut

      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // system icon 들의 색상을 밝게 하여 이미지랑 어울리게 함.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return SafeArea(
      top:true,
      bottom: true,
      child: PageView(
        controller: pageController,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 178, 82),
            ),
            child: Center(
              child: Container(
                width: 300,
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/farmer.png", width: 200, height: 200),
                        //const LinearProgressIndicator(),
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Color.fromARGB(255, 144, 213, 146)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //pageview images
      
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 178, 82),
            ),
            child: Center(
              child: Container(
                width: 300,
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/splash_02.png", width: 300, height: 400),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Image.asset("images/splash_01.png", fit: BoxFit.cover),
          Image.asset("images/splash_01.png", fit: BoxFit.contain)
        ],
      ),
    );
  }
}
