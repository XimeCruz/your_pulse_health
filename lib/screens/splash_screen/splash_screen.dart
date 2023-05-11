import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/data/user_data.dart';
import 'package:your_pulse_health/screens/onboarding/page/onboarding_page.dart';
import 'package:your_pulse_health/screens/tab_bar/page/tab_bar_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final currUser = FirebaseAuth.instance.currentUser;
    final isLoggedIn = currUser != null;
    if (isLoggedIn) {
      GlobalConstants.currentUser = UserData.fromFirebase(currUser);
    }

    return AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/images/splash/yourpulselogo.png',
        nextScreen: isLoggedIn ? TabBarPage() : OnboardingPage(),
        //nextScreen: ChooseSession(),
        splashIconSize: 250,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: Colors.white);
  }
}