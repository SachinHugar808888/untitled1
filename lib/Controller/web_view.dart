import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String initialUrl;

  MyWebView({required this.initialUrl});

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      navigationDelegate: (NavigationRequest request) {
        // Handle navigation requests, e.g., check for specific URLs
        if (request.url.contains('/accept')) {
          // Perform the accept action
          handleAcceptAction();
          return NavigationDecision.prevent;
        } else if (request.url.contains('/finish')) {
          // Perform the finish action
          handleFinishAction();
          return NavigationDecision.prevent;
        } else if (request.url.contains('/reject')) {
          // Perform the reject action
          handleRejectAction();
          return NavigationDecision.prevent;
        }

        // Allow navigation for other URLs
        return NavigationDecision.navigate;
      },
    );
  }

  void handleAcceptAction() {
    // Perform actions for the accept action
    print('Accepted!');
    _webViewController.evaluateJavascript("console.log('Accept action performed');");
  }

  void handleFinishAction() {
    // Perform actions for the finish action
    print('Finished!');
    _webViewController.evaluateJavascript("console.log('Finish action performed');");
  }

  void handleRejectAction() {
    // Perform actions for the reject action
    print('Rejected!');
    _webViewController.evaluateJavascript("console.log('Reject action performed');");
  }
}
