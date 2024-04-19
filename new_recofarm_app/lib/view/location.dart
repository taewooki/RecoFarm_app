import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class location extends StatefulWidget {
  const location({Key? key}) : super(key: key);

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  late String userId;
  late String password;
  late String username;
  late List<int> selectedIndexes;
  late List<String> imagePaths; // 이미지 파일의 경로를 저장할 리스트

  @override
  void initState() {
    super.initState();
    userId = "";
    password = "";
    username = "";
    selectedIndexes = [];
    imagePaths = []; // 이미지 파일의 경로 리스트 초기화

    initSharedPreferences();
  }

  initSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString('p_userid') ?? "";
      password = pref.getString('p_userpw') ?? "";
      username = pref.getString('p_username') ?? "";
      selectedIndexes = pref
              .getStringList('selected_indexes')
              ?.map((index) => int.parse(index))
              .toList() ??
          [];
      imagePaths = [
        "images/가지.jpg",
        "images/감자.jpg",
        "images/고구마.webp",
        "images/고추.webp",
        "images/귤.webp",
        "images/깻잎.jpg",
        "images/대파.jpeg",
        "images/딸기.webp",
        "images/마늘.jpg",
        "images/배추.webp",
        "images/가지.jpg",
        "images/감자.jpg",
        "images/가지.jpg",
        "images/감자.jpg",
        "images/가지.jpg",
        // 나머지 이미지 경로들을 여기에 추가
      ]; // 이미지 파일의 경로 리스트 초기화
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('관심 위치'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Username: $username'),
            // Text('UserID: $userId'),
            // Text('Password: $password'),
            // if (selectedIndexes.isNotEmpty) // 선택된 이미지가 있을 때만 표시
            Column(
              children: [
                // Text(
                //   'Selected Image 1: ${getImageName(selectedIndexes.first)}',
                // ),
                // if (selectedIndexes.length > 1)
                //   Text(
                //     'Selected Image 2: ${getImageName(selectedIndexes[1])}',
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // String getImageName(int index) {
  //   return imagePaths[index]
  //       .split('/')
  //       .last
  //       .split('.')
  //       .first; // 파일 경로에서 파일 이름만 추출하고 확장자를 제거
  // }
}
