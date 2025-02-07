import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' hide NavigationDecision;
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:url_launcher/url_launcher.dart';
class FlutterFlowWebView extends StatefulWidget {
  const FlutterFlowWebView({
    Key? key,
    required this.content,
    this.width,
    this.height,
    this.bypass = false,
    this.horizontalScroll = false,
    this.verticalScroll = false,
    this.html = false,
    this.onPageStarted,
    this.onPageFinished,
    this.onProgress,
    this.onWebViewCreated,
    this.onSomeDataLoaded, // Callback when some data is loaded
  }) : super(key: key);
  final String content;
  final double? height;
  final double? width;
  final bool bypass;
  final bool horizontalScroll;
  final bool verticalScroll;
  final bool html;
  final void Function(String)? onPageStarted;
  final void Function(String)? onPageFinished;
  final void Function(double)? onProgress;
  final void Function(double)? onWebViewCreated;
  final void Function()? onSomeDataLoaded; // Callback for some data loaded
  @override
  _FlutterFlowWebViewState createState() => _FlutterFlowWebViewState();
}
class _FlutterFlowWebViewState extends State<FlutterFlowWebView> {
  late WebViewXController webViewController;
  double lastProgress = 0.0;
  @override
  Widget build(BuildContext context) => WebViewX(
    key: webviewKey,
    width: widget.width ?? MediaQuery.sizeOf(context).width,
    height: widget.height ?? MediaQuery.sizeOf(context).height,
    ignoreAllGestures: false,
    initialContent: widget.content,
    initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.requireUserActionForAllMediaTypes,
    initialSourceType: widget.html
        ? SourceType.html
        : widget.bypass
        ? SourceType.urlBypass
        : SourceType.url,
    javascriptMode: JavascriptMode.unrestricted,
    onWebViewCreated: (controller) async {
      webViewController = controller;
      _monitorProgress(); // Start monitoring progress
    },
    navigationDelegate: (request) async {
      if (Platform.isAndroid && request.content.source.startsWith('https://api.whatsapp.com/send?phone')) {
        final url = request.content.source;
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        return NavigationDecision.prevent;
      }
      return NavigationDecision.navigate;
    },
    onPageStarted: widget.onPageStarted,
    onPageFinished: (url) {
      widget.onPageFinished?.call(url);
      widget.onProgress?.call(100); // Callback for 100% loaded
    },
  );
  Key get webviewKey => Key(
    [
      widget.content,
      widget.width?.toString(),
      widget.height?.toString(),
      widget.bypass.toString(),
      widget.horizontalScroll.toString(),
      widget.verticalScroll.toString(),
      widget.html.toString(),
    ].join('_'),
  );
  Future<void> _monitorProgress() async {
    while (true) {
      try {
        // Evaluate the progress of page loading
        final result = await webViewController.evalRawJavascript(
          """
        (function() {
          if (document.readyState === 'complete') {
            return 100;
          }
          var scrollTop = window.pageYOffset || document.documentElement.scrollTop;
          var scrollHeight = document.documentElement.scrollHeight - window.innerHeight;
          var progress = Math.round((scrollTop / scrollHeight) * 100);
          return progress;
        })();
        """,
        );
        final progressValue = double.tryParse(result.toString()) ?? 0.0;
        // Continuously call the onProgress callback when the progress value changes
        if (progressValue != lastProgress) {
          lastProgress = progressValue;
          widget.onProgress?.call(progressValue); // Trigger the callback
        }
        // Check if some data has loaded (e.g., when a certain number of elements are present)
        final dataLoaded = await webViewController.evalRawJavascript(
            """
        var items = document.querySelectorAll('.data-item'); // Adjust the selector
        return items.length;
        """
        );
        final loadedDataCount = int.tryParse(dataLoaded.toString()) ?? 0;
        // Debug print to check how many items have loaded
        debugPrint('Loaded data count: $loadedDataCount');
        // If the data is loaded (e.g., 10 items), trigger the callback
        if (loadedDataCount > 0) {
          if (widget.onSomeDataLoaded != null) {
            widget.onSomeDataLoaded!(); // Trigger the callback when some data is loaded
          }
        }
        // Stop monitoring once the page is fully loaded
        if (progressValue == 100) {
          debugPrint('Page fully loaded');
          break;
        }
        // Short delay before checking again
        await Future.delayed(const Duration(milliseconds: 200));
      } catch (e) {
        debugPrint('Error monitoring progress: $e');
        break;
      }
    }
  }
}