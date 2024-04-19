import 'package:flutter/material.dart';
import 'package:new_recofarm_app/view/home.dart';
import 'package:new_recofarm_app/view/home_view_page.dart';

/*
 
  Description : 
          
                현재 Page는 추후에 로그인 이후 가장먼저 사용자에게 보여주는 홈화면으로 만들 생각입니다.
                TabBarView를 이용하여 각각 tabbar에 맞는 class를 만들어 주시면 됩니다.
                tabbar를 몇개로 할건지 또한 미정. 

  Date        : 2024-04-17 13:32
  Author      : lcy
  Updates     : 
  Detail      : - 

*/

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {

  late TabController tController;

  @override
  void initState() {
    super.initState();
    tController = TabController(
      length: 2,
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tController,
        children: [
          HomeViewPage(),
          Home()
        ]
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        child: TabBar(
          controller: tController,
          labelColor: Colors.green,
          indicatorColor: Colors.red,
          indicatorWeight: 4,
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'ex home',
            ),
            Tab(
              icon: Icon(Icons.looks_two_outlined),
              text: 'ex one',
            ),
            // Tab(
            //   icon: Icon(Icons.looks_two_outlined),
            //   text: 'ex one',
            // ),
          ],
        ),
      ),
    );
  }
}