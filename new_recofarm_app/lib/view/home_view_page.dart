import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_recofarm_app/model/user_model.dart';
import 'package:new_recofarm_app/view/detail_cabbageapi.dart';
import 'package:new_recofarm_app/view/drawer_widget.dart';
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
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: UserFirebase().selectUserEqaulPhone('01022842745'),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
                final UserModel userModel = UserModel(
                name: snapshot.data!.docs[0]['name'], 
                phone: snapshot.data!.docs[0]['phone'], 
                nickName: snapshot.data!.docs[0]['nickname'],
                userImagePath: snapshot.data!.docs[0]['image']);
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
                                    '${userModel.name}  ',
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GetBuilder<NapaCabbageAPI>(
                          builder: (cabbageController) {
                            return Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 15),
                                  child: Text(
                                    '오늘의 배추가격은?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 50,
                                  height: 200,
                                  child: Swiper(
                                    loop: cabbageController.loopStatus,
                                    itemCount: cabbageController.apiModel.length,
                                    pagination: const SwiperPagination(),
                                    control: const SwiperControl(),
                                    autoplay: true,
                                    autoplayDelay: 5000,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              color: Theme.of(context).colorScheme.secondaryContainer
                                            ),
                                            width: MediaQuery.of(context).size.width - 50,
                                            height: 200,
                                            child: cabbageController.apiModel.isNotEmpty?
                                            Column(
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
                                                      const CircleAvatar(
                                                        backgroundImage: AssetImage('images/Cabbage.png'),
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                      ),
                                                      const SizedBox(
                                                        width: 50,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            '${cabbageController.apiModel[index]['marketName']}',
                                                            style: const TextStyle(
                                                              fontSize: 17
                                                            ),
                                                          ),
                                                          Text(
                                                            '${cabbageController.apiModel[index]['sClassName']}'
                                                          ),
                                                          Text(
                                                            '${cabbageController.apiModel[index]['weight']} 당 ',
                                                            style: const TextStyle(
                                                              fontSize: 17
                                                            ),
                                                          ),
                                                          Text(
                                                            '평균 ${cabbageController.apiModel[index]['price']}원',
                                                            style: const TextStyle(
                                                              fontSize: 19
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                            : const Text('데이터가 존재하지 않습니다.')
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 270,
                                    ),
                                    TextButton(
                                      onPressed: () => Get.to(const DetailCabbage()),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.blue
                                      ),
                                      child: const Text(
                                        '자세히 보기',
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      )
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ],
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
