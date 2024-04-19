import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_recofarm_app/view/gps.dart';
import 'package:new_recofarm_app/view/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageData {
  final String imagePath;
  final String title;

  ImageData({required this.imagePath, required this.title});
}

class Inter extends StatefulWidget {
  const Inter({Key? key}) : super(key: key);

  @override
  _InterState createState() => _InterState();
}

class _InterState extends State<Inter> {
  late String userId;
  late String password;
  late String username;
  List<bool> _selected = List.generate(15, (index) => false);

  List<ImageData> _imagelist = [
    ImageData(imagePath: "images/가지.jpg", title: "가지"),
    ImageData(imagePath: "images/감자.jpg", title: "감자"),
    ImageData(imagePath: "images/고구마.webp", title: "고구마"),
    ImageData(imagePath: "images/고추.webp", title: "고추"),
    ImageData(imagePath: "images/귤.webp", title: "귤"),
    ImageData(imagePath: "images/깻잎.jpg", title: "깻잎"),
    ImageData(imagePath: "images/대파.jpeg", title: "대파"),
    ImageData(imagePath: "images/딸기.webp", title: "딸기"),
    ImageData(imagePath: "images/마늘.jpg", title: "마늘"),
    ImageData(imagePath: "images/배추.webp", title: "배추"),
    ImageData(imagePath: "images/가지.jpg", title: "가지"),
    ImageData(imagePath: "images/감자.jpg", title: "감자"),
    ImageData(imagePath: "images/가지.jpg", title: "가지"),
    ImageData(imagePath: "images/감자.jpg", title: "감자"),
    ImageData(imagePath: "images/가지.jpg", title: "가지"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = "";
    password = "";
    initSharedPreferences();
  }

  initSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    userId = pref.getString('p_userid')!;
    password = pref.getString('p_userpw')!;
    username = pref.getString('p_username')!;
    setState(() {});
  }

  void _handleTap(int index) {
    setState(() {
      // 선택된 항목이 3개를 초과하지 않도록 체크
      int selectedCount = _selected.where((selected) => selected).length;
      if (!_selected[index] && selectedCount >= 3) {
        // 선택된 항목이 3개를 초과하면 아무 작업도 수행하지 않음
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("알림"),
              content: Text("최대 3개까지만 선택할 수 있습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("확인"),
                ),
              ],
            );
          },
        );
      } else {
        // 선택된 항목이 3개 이하이거나 체크를 취소하는 경우
        _selected[index] = !_selected[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '관심 작물',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  '가격 동향',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' 을 선택하면',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  "을 알려드려요",
                  style: TextStyle(
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "3개 선택 필수입니다.", // 텍스트 내용을 원하는 내용으로 변경
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10.0), // 텍스트와 원 사이의 간격 조정
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _handleTap(index),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200, // 이미지 크기에 맞게 조정
                          height: 200, // 이미지 크기에 맞게 조정
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _selected[index]
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 4, // 선택된 경우 테두리 두께를 조정
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(_imagelist[index].imagePath),
                          ),
                        ),
                        if (_selected[index])
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 선택된 항목 수
                int selectedCount =
                    _selected.where((selected) => selected).length;

                // 선택된 항목이 3개인 경우에만 다음 페이지로 이동
                if (selectedCount == 3) {
                  saveSharedPreferences(); // SharedPreferences에 선택된 항목 저장
                  Get.to(
                    const GPSPage(),
                    arguments: {
                      'username': username,
                      'userid': userId,
                      'userpw': password,
                    },
                  );
                } else {
                  // 선택된 항목이 3개가 아닌 경우 알림 대화 상자 표시
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("알림"),
                        content: Text("3개의 항목을 선택해야 합니다."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("확인"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('다음'),
            ),
          ],
        ),
      ),
    );
  }

  saveSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> selectedIndexes = [];
    for (int i = 0; i < _selected.length; i++) {
      if (_selected[i]) {
        selectedIndexes.add(i);
      }
    }
    await prefs.setStringList('selected_indexes',
        selectedIndexes.map((index) => index.toString()).toList());
  }
}
