import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_recofarm_app/vm/napacabbage_price_api.dart';
import 'package:new_recofarm_app/vm/user_firebase.dart';


/*
 
  Description : 사용자에게 보여줄 메인 화면입니다.
  Date        : 2024-04-17 13:32
  Author      : lcy
  Updates     : 
  Detail      : - 

*/

class HomeViewPage extends StatelessWidget {

//   initSharedPreferences() async {
//   final pref = await SharedPreferences.getInstance();
//   userId = pref.getString('p_userid')!;
//   password = pref.getString('p_userpw')!;
// }

  HomeViewPage({super.key});


  @override
  Widget build(BuildContext context) {

    final NapaCabbageAPI cabbageController = Get.put(NapaCabbageAPI());
    cabbageController.fetchXmlData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reco Farm'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search)
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // backgroundImage: AssetImage(
                //   'images/image1.jpg'
                // ),
                backgroundColor: Colors.amber,
              ),
              accountName: Text('파이리'),
              accountEmail: Text('pikachu@naver.com'),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight : Radius.circular(30),
                )
              ),
            ), // UserAccountsDrawerHeader
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.red,  
              ),
              title: const Text('Home'),
              onTap: () => {print('home')},
            ),
            const ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              title: Text('설정')
            ),
            const ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.orange,
              ),
              title: Text('자주 묻는 질문')
            )
          ], // children
        ) // ListView
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: UserFirebase().selectUserEqaulPhone('01022842745'),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              final user = snapshot.data!.docs[0];
              // 불러온 데이터가 있을 때,
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        width: 300,
                        height: 400,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${user['name']}  ',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const Text(
                                    '님의 관심 작물은?',
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              height: 310,
                              child: Swiper(
                                itemBuilder: (BuildContext context,int index){
                                  return Container(
                                    color: Colors.blue
                                  );
                                },
                                itemCount: 3,
                                pagination: SwiperPagination(),
                                control: SwiperControl(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GetBuilder<NapaCabbageAPI>(
                            builder: (cabbageController) {
                              return Column(
                                children: [
                                  const Text(
                                    '오늘의 배추가격은?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 50,
                                    height: 300,
                                    child: Swiper(
                                      loop: cabbageController.loopStatus,
                                      itemCount: cabbageController.apiModel.length,
                                      pagination: const SwiperPagination(),
                                      control: const SwiperControl(),
                                      autoplay: true,
                                      autoplayDelay: 5000,
                                      itemBuilder: (context, index) {
                                        if(cabbageController.apiModel.isEmpty) {
                                          return const CircularProgressIndicator();
                                        }
                                        return Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: const Color.fromARGB(255, 211, 207, 207),
                                              ),
                                              width: MediaQuery.of(context).size.width - 50,
                                              height: 300,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 7),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${cabbageController.apiModel[index]['date']!.substring(0,4)} - ${cabbageController.apiModel[index]['date']!.substring(4,6)} - ${cabbageController.apiModel[index]['date']!.substring(6,8)}',
                                                          style: const TextStyle(
                                                            fontSize: 18
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage: AssetImage('images/Cabbage.png'),
                                                          radius: 40,
                                                        ),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '${cabbageController.apiModel[index]['marketName']}',
                                                              style: TextStyle(
                                                                fontSize: 17
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   '${cabbageController.apiModel[index]['mClassname']}'
                                                            // ),
                                                            Text(
                                                              '${cabbageController.apiModel[index]['weight']} 당 ',
                                                              style: TextStyle(
                                                                fontSize: 17
                                                              ),
                                                            ),
                                                            Text(
                                                              '${cabbageController.apiModel[index]['price']}원',
                                                              style: TextStyle(
                                                                fontSize: 19
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      )
    );
  }

}
