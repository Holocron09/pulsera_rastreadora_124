import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MiniWebBrowser extends StatefulWidget {
  MiniWebBrowser({
    @required this.title,
    @required this.initialUrl,
  })  : assert(title != null),
        assert(initialUrl != null);

  final String title;
  final String initialUrl;

  @override
  _MiniWebBrowserState createState() => _MiniWebBrowserState();
}

class _MiniWebBrowserState extends State<MiniWebBrowser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[],
      ),
      body: Card(
        child: WebView(
          initialUrl: widget.initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
