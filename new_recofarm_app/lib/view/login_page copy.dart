import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class PhoneAuthTest extends StatefulWidget {
  @override
  _PhoneAuthTestState createState() => _PhoneAuthTestState();
}

class _PhoneAuthTestState extends State<PhoneAuthTest> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Random random = Random();

  bool showLoading = false;

  // 사용자의 이메일을 난수로 처리하여 반환하는 함수
  String generateRandomEmail(String email) {
    String randomString = email.substring(0, email.indexOf('@')) +
        random.nextInt(10000).toString() +
        '@example.com';
    return randomString;
  }

  Future<void> signUpUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      // Firebase에 사용자 등록을 먼저 수행합니다.
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: generateRandomEmail(email), // 이메일을 난수로 처리합니다.
        password: password,
      );

      // 가입 완료 메시지 표시
      Fluttertoast.showToast(
        msg: "가입 완료! 이메일 인증 링크를 보냈습니다.",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        fontSize: 16.0,
      );

      // 이메일 인증을 보냅니다.
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        await user.sendEmailVerification();
      } else {
        // 사용자가 null인 경우 오류 메시지 표시
        throw Exception('사용자가 null입니다.');
      }

      setState(() {
        showLoading = false;
      });

      // 사용자의 인증 상태를 감시하고 이메일이 확인되면 사용자의 이메일을 업데이트합니다.
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null && user.emailVerified) {
          // 이메일 주소를 업데이트합니다.
          user.verifyBeforeUpdateEmail(email).then((_) {
            // 이메일 주소 업데이트 완료 메시지 표시
            Fluttertoast.showToast(
              msg: "이메일 주소가 확인되었습니다.",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              fontSize: 16.0,
            );
          }).catchError((error) {
            print("이메일 주소 업데이트 오류: $error");
          });
        }
      });
    } catch (error) {
      // 예외 처리
      setState(() {
        showLoading = false;
      });

      String errorMessage = "회원 가입 중 오류가 발생했습니다.";
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          errorMessage = "비밀번호 보안 수준이 낮습니다.";
        } else if (error.code == 'email-already-in-use') {
          errorMessage = "이미 사용 중인 이메일 주소입니다.";
        } else if (error.code == 'invalid-email') {
          errorMessage = "유효하지 않은 이메일 주소입니다.";
        } else {
          errorMessage = "오류: ${error.message}";
        }
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
        title: Text('회원 가입'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: SizedBox(
                height: 46,
                child: Column(
                  children: [
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
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Text("비밀번호 재입력")),
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
                                hintText: "비밀번호 재입력",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: verifyPasswordController,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      child: Text('가입하기'),
                      onPressed: () async {
                        setState(() {
                          showLoading = true;
                        });

                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        String verifyPassword =
                            verifyPasswordController.text.trim();

                        if (email.isEmpty ||
                            password.isEmpty ||
                            verifyPassword.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "이메일 및 비밀번호를 입력해 주세요.",
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

                        if (password != verifyPassword) {
                          Fluttertoast.showToast(
                            msg: "비밀번호를 확인해 주세요.",
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

                        // Firebase에 사용자 등록 후 이메일 인증 보내기
                        await signUpUserWithEmailAndPassword(
                            context, email, password);
                      },
                    ),
                  ],
                ),
              ),
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
