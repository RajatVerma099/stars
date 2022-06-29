import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'home_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                  child: const Text('No no noo 😳'),
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
    },child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Celestial Sights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
      splash: Image.asset('assets/infinity.gif', fit: BoxFit.cover),
    splashIconSize: 200,
    splashTransition: SplashTransition.scaleTransition,
    backgroundColor: Colors.black,
    duration: 9000,

    nextScreen: const HomePage(),
      ),
    ),
    );
  }
}
