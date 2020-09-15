import 'dart:async';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

WebViewController globalWebViewController;

class NearbyMedicos extends StatefulWidget {

  @override
  _NearbyMedicosState createState() => _NearbyMedicosState();
}

class _NearbyMedicosState extends State<NearbyMedicos> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       color: kScaffoldBackgroundColor,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 500,
                      child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        gestureNavigationEnabled: true,
                        debuggingEnabled: false,
                        initialUrl: 'https://www.google.com/maps/search/hospitals/',
                        onWebViewCreated: (WebViewController webViewController) {
                          this.webViewController = webViewController;
                          globalWebViewController = webViewController;
                          _controller.complete(webViewController);
                        },
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        height: 62.0,
                        width: MediaQuery.of(context).size.width,
                        color: kMapsGreyColor,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Nearby Medicos',
                              style: kBottomNavBarTextStyle.copyWith(color: kLightAmberColor, fontSize: 30.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 45.0,
                    color: kMapsGreyColor,
                    child: NavigationControls(_controller.future),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      'Powered by Google Maps ©',
                      style: TextStyle(
                          color: kTealColor,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black45,
                  size: 30.0,
                ),
                onPressed: !webViewReady
                    ? null
                    : () => navigate(context, controller, goBack: true),
              ),
              IconButton(
                color: kAmberColor,
                icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black45,
                    size: 30.0
                ),
                onPressed: !webViewReady
                    ? null
                    : () => navigate(context, controller, goBack: false),
              ),
              IconButton(
                color: kAmberColor,
                icon: const Icon(
                    Icons.home,
                    color: Colors.black45,
                    size: 30.0
                ),
                onPressed: !webViewReady
                    ? null
                    : () {
                  globalWebViewController.loadUrl('https://www.google.com/maps/search/hospitals/');
                },
              ),
              IconButton(
                color: kAmberColor,
                icon: const Icon(
                    Icons.refresh,
                    color: Colors.black45,
                    size: 30.0
                ),
                onPressed: !webViewReady
                    ? null
                    : () {
                  globalWebViewController.reload();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
    goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }
}
