import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:new_recofarm_app/view/interesting.dart';
import 'package:new_recofarm_app/view/second_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with WidgetsBindingObserver {
  late TextEditingController userIdController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController; // 비밀번호 재확인 필드 추가
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    userIdController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController(); // 비밀번호 재확인 필드 초기화
    nameController = TextEditingController();
    initSharedPreferences();
  }

  initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    userIdController.text = prefs.getString('p_userid') ?? "";
    passwordController.text = prefs.getString('p_userpw') ?? "";
    nameController.text = prefs.getString('p_username') ?? "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        disposeSharedPreferences();
        break;
      default:
        break;
    }
  }

  disposeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 가입'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password', // 비밀번호 재확인 필드 라벨 추가
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (userIdController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty ||
                      nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('빈칸을 입력해주세요.')),
                    );
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('비밀번호가 일치하지 않습니다.')),
                    );
                  } else {
                    saveSharedPreferences();
                    Get.to(const Inter());
                  }
                },
                child: const Text('다음'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('p_userid', userIdController.text);
    prefs.setString('p_userpw', passwordController.text);
    prefs.setString('p_username', nameController.text);
  }
}
