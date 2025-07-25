import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
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
      ..loadRequest(Uri.base.resolve('unity/index.html'));
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
    Future.delayed(const Duration(seconds: 1), () {
      print("loading unity game");
      if (ref.watch(userServiceProvider).user == null) {
        ref.read(userServiceProvider.notifier).getCurrentUser();
      }
      final token =
          "${ref.watch(authServiceProvider).token} ${ref.watch(userServiceProvider).user!.id}";
      print("Sending token: $token");
      _sendMessageToUnity(token);
    });
    return Scaffold(body: WebViewWidget(controller: _controller));
  }
}
