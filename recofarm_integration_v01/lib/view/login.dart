import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool showLoading = false;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Firebase에 이메일과 비밀번호로 로그인을 시도합니다.
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 로그인 완료 메시지 표시
      Fluttertoast.showToast(
        msg: "로그인 완료!",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        fontSize: 16.0,
      );

      setState(() {
        showLoading = false;
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        showLoading = false;
      });

      String errorMessage = "로그인 중 오류가 발생했습니다.";
      if (error.code == 'user-not-found') {
        errorMessage = "등록되지 않은 이메일입니다.";
      } else if (error.code == 'wrong-password') {
        errorMessage = "잘못된 비밀번호입니다.";
      } else {
        errorMessage = "오류: 이메일 혹은 비밀번호를 다시 입력하세요";
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 60.0), // 상단 패딩 추가
                Row(
                  children: [
                    Expanded(flex: 1, child: Text("이메일")),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            isDense: true,
                            hintText: "이메일 입력",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(flex: 1, child: Text("비밀번호")),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            isDense: true,
                            hintText: "비밀번호 입력",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: passwordController,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('로그인'),
                  onPressed: () async {
                    setState(() {
                      showLoading = true;
                    });

                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "이메일과 비밀번호를 입력해 주세요.",
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        fontSize: 16.0,
                      );
                      setState(() {
                        showLoading = false;
                      });
                      return;
                    }

                    // Firebase에 이메일과 비밀번호로 로그인
                    await signInWithEmailAndPassword(email, password);
                  },
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Visibility(
              visible: showLoading,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 80,
                    color: Colors.white,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          ),
                          SizedBox(width: 20),
                          Text("잠시만 기다려 주세요"),
                          SizedBox(width: 20),
                          Opacity(
                            opacity: 0,
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
