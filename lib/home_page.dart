import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_player/video_player.dart';

import 'in_app_browser_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}




class _HomePageState extends State<HomePage> {
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  late VideoPlayerController controller;
  @override
  // @override
// void initState() {
//   super.initState();
//
//   WidgetsBinding.instance!.addPostFrameCallback((_) {
//     widget.browser.open(
//         url: Uri.parse("https://flutter.dev/"),
//         options: ChromeSafariBrowserClassOptions(
//             android: AndroidChromeCustomTabsOptions(
//                 addDefaultShareMenuItem: false),
//             ios: IOSSafariOptions(barCollapsingEnabled: true)));
//   },
//   });
//
// }
  void initState()
  {
    super.initState();
    controller= VideoPlayerController.asset('assets/vid.mp4')..initialize().then((_) {
      setState(() {
             });
    });
    controller.setVolume(200);
    controller.setLooping(true);
    controller.play();
  }
  _initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3694674512376083/8570933977',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ), request: AdRequest(),
    );
    bannerAd.dispose();
    bannerAd.load();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:() async {
          final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  title: const Text(
                      'Are you leaving ?',style:TextStyle (color: Colors.white,)

                  ),
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Stars Tonight", style:TextStyle (color: Colors.white,),),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children:<Widget>[
          VideoPlayer(controller),
          Center(child: Container(
            child: TextButton(
                 onPressed: () {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => InAppBrowserPage())
                   );
                 },
                 child: Center(
                   child: Text(""),
                 ),
               ),
            ),
          ),],
          ),

      bottomNavigationBar: isAdLoaded ? Container(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd),
      ) : SizedBox(),
    ),
    );




  }
}
