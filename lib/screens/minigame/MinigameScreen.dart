import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MinigameScreen extends StatefulWidget {
  const MinigameScreen({super.key});

  @override
  State<MinigameScreen> createState() => _MinigameScreenState();
}

class _MinigameScreenState extends State<MinigameScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.base.resolve('web/unity/index.html'));
    // _controller.loadFlutterAsset('web/unity/index.html');
  }

  @override
  Widget build(BuildContext context) {
    print("loading unity game");
    return Scaffold(body: WebViewWidget(controller: _controller));
  }
}
