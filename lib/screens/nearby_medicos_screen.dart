import 'dart:async';
import 'package:eye_diagnostic_system/screens/main_dashboard_screen.dart';
import 'package:eye_diagnostic_system/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NearbyMedicos extends StatefulWidget {
  static const String id = 'nearby_medicos_screen';

  @override
  _NearbyMedicosState createState() => _NearbyMedicosState();
}

class _NearbyMedicosState extends State<NearbyMedicos> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  WebViewController _webViewController;

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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/images/eye.png'),
                      height: 140.0,
                      width: 140.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 12.0),
                  child: Container(
                    height: 450,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: WebView(
                          javascriptMode: JavascriptMode.unrestricted,
                          gestureNavigationEnabled: true,
                          debuggingEnabled: false,
                          initialUrl: 'https://www.google.com/maps/search/optometrist/',
                          onWebViewCreated: (WebViewController webViewController) {
                            this._webViewController = webViewController;
                            _controller.complete(webViewController);
                          },
                        ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: 80,
                    color: kPurpleColor,
                    child: NavigationControls(_controller.future),
                  ),
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold
                              ),
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
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFffbd00),
                  size: 48.0,
                ),
                onPressed: !webViewReady
                    ? null
                    : () => navigate(context, controller, goBack: true),
              ),
              IconButton(
                color: kGoldenColor,
                icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFffbd00),
                    size: 48.0
                ),
                onPressed: !webViewReady
                    ? null
                    : () => navigate(context, controller, goBack: false),
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
