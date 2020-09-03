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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: kBgColorGradientArrayBlues,
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
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
                      height: 480,
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
                              style: kBottomNavBarTextStyle.copyWith(color: Colors.black45, fontSize: 30.0),
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
                  height: 25.0,
                ),
                Container(
                  height: 64.0,
                  //color: kPurpleColor,
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24.0,
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                                'Back',
                                style: kBottomNavBarTextStyle
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, Dashboard.id);
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            'Powered by Google Maps ©',
                            style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic
                            ),
                          ),
                        ),
                      ),
                    ],
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
                color: kGoldenColor,
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
                color: kGoldenColor,
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
                color: kGoldenColor,
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
