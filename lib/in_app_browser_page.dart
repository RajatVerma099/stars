
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppBrowserPage extends StatefulWidget {
const  InAppBrowserPage({Key? key}) : super(key: key);

  @override
  State<InAppBrowserPage> createState() => _InAppBrowserPageState();
}

class _InAppBrowserPageState extends State<InAppBrowserPage> {
  double _progress=0;
late  InAppWebViewController webView;
GlobalKey <ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:() async {
      final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you leaving ?'),
              content: const Text('🙂 '),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No no nooo 😳'),
                ),
                ElevatedButton(onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('yess 🥱'),
                ),
              ],
            );
          });
      if (value != null) {
        return Future.value(value);
      }
      else {
        return Future.value(false);
      }
    },child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
            "Stars are aligning...",
        style: TextStyle(color: Colors.white),
      ),
      ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest : URLRequest(
                  url: Uri.parse("https://stellarium-web.org")
                // url: Uri.parse("https://www.timeanddate.com/astronomy/night/")
              ),
              onWebViewCreated: (InAppWebViewController controller)
                {
                  webView= controller;
                },
              onProgressChanged: (InAppWebViewController controller, int progress)
              {
                setState(() {
                  _progress= progress/100;
                });
              },
            ),
            _progress<1? SizedBox(
              height: 3,
                child: LinearProgressIndicator(
                  value: _progress,
                  backgroundColor: Colors.deepPurpleAccent,
                ),
            ):
                SizedBox()
          ],
        ),
    //     bottomNavigationBar: isAdLoaded ? Container(
    // height: bannerAd.size.height.toDouble(),
    //   width: bannerAd.size.width.toDouble(),
    //   child: AdWidget(ad: bannerAd),
    // ) : SizedBox(),
      ),
    );

  }
}
