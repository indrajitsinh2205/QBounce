import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Import specific WebView packages
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final String url = 'https://flutter.dev';
  // final String url = 'https://www.appmatictech.com';
  final String url = 'https://quietbounce.com/?trafficSource=qbounce.netlify.app';
  // ?trafficSource=qbounce.netlify.app
  bool isLoading = true;
  late final dynamic _controller; // Use dynamic to handle different controller types.

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      // Use WebViewController for WKWebView
      _controller = WebViewController();
      _controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              print("Page loading started: $url");
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (String url) {
              print("Page loading finished: $url");
              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              print(
                  "Failed to load URL: ${error.url}, Error: ${error.description}");
              setState(() {
                isLoading = false;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    } else if (Platform.isAndroid) {
      // Use WebViewController for Android
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              print("Page loading started: $url");
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (String url) {
              print("Page loading finished: $url");
              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              print(
                  "Failed to load URL: ${error.url}, Error: ${error.description}");
              // setState(() {
                isLoading = false;
              // });
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          if (Platform.isIOS)
            WebViewWidget(controller: _controller)
          else if (Platform.isAndroid)
            WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
