import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
 
  Description : Webview 
  Date        : 2024.04.20 Sat
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
	  2024.04.20 Sat by pdg
		  - 별로 쓸때가 없지만 일단 플러터 복습하는김에 만들어 보았다.
  Detail      : - 

*/
class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController webViewController;
  late bool isLoading;
  late String siteName;
  late TextEditingController tfController;


  @override
  void initState() {
    super.initState();
    siteName = "www.nongnet.or.kr/";
    isLoading =true;
    tfController = TextEditingController(
      text: siteName
    );
    webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading = true;
            setState(() {});
          },
          onProgress: (progress) {
            isLoading = true;
            setState(() {});
          },
          onPageFinished: (url) {
            isLoading = false;
            setState(() {});
          },
          onWebResourceError: (error) {
            isLoading = false;
            setState(() {});
          },
        ),
      ) 
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://$siteName'));
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Farmers Web",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 219, 109),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
