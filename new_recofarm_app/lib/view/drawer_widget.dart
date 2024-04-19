import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_recofarm_app/vm/user_firebase.dart';

class DrawerWidget extends StatelessWidget {

  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<QuerySnapshot>(
        stream: UserFirebase().selectUserEqaulPhone('01022842745'),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return const Center(child: Text('데이터가 없습니다.'),);
          }
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  // backgroundImage: AssetImage(
                  //   'images/image1.jpg'
                  // ),
                  backgroundColor: Colors.amber,
                ),
                accountName: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 30, 0, 0),
                  child: Text(
                    '${snapshot.data!.docs[0]['name']}님',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                accountEmail: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    '${snapshot.data!.docs[0]['nickname']}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight : Radius.circular(30),
                  )
                ),
              ),
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
          );
        },
      ) // ListView
    );
  }
}