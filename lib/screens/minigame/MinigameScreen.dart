import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:js' as js;

class MinigameScreen extends ConsumerStatefulWidget {
  const MinigameScreen({super.key});

  @override
  ConsumerState<MinigameScreen> createState() => _MinigameScreenState();
}

class _MinigameScreenState extends ConsumerState<MinigameScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.base.resolve('unity/index.html'));
    // _controller.loadFlutterAsset('web/unity/index.html');
  }

  void _sendMessageToUnity(String message) {
    print("Message $message");
    js.context.callMethod('eval', [
      '''
      var unityIframe = document.querySelector('iframe'); // Select the Unity iframe
      if (unityIframe) {
        console.log('Found unity Iframe');
        unityIframe.contentWindow.postMessage({ from: 'flutter', message: '$message' }, '*');
      } else {
        console.error('Unity iframe not found');
      }
    ''',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      print("loading unity game");
      final token = ref.watch(authServiceProvider).token ?? "";
      print("Sending token: $token");
      _sendMessageToUnity(token);
    });
    return Scaffold(body: WebViewWidget(controller: _controller));
  }
}
