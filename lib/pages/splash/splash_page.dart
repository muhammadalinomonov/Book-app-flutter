import 'package:book_app/data/source/shpref/my_shared_pref.dart';
import 'package:book_app/pages/home/home_screen.dart';
import 'package:book_app/pages/intro/intro_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final pref = MySharedPref();

  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      var isFirst = await pref.getBool();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          if (isFirst) {
            return IntroPage();
          } else
            return HomeScreen();
        }), // Replace 'IntroPage()' with the actual instantiation of your Intro page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset("assets/icons/ic_splash.svg"),
        ),
      ),
    );
  }
}
