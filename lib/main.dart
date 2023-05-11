import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/core/service/notification_service.dart';
import 'package:your_pulse_health/data/user_data.dart';
//import 'package:your_pulse_health/screens/onboarding/page/onboarding_page.dart';
import 'package:your_pulse_health/screens/splash_screen/splash_screen.dart';
//import 'package:your_pulse_health/screens/tab_bar/page/tab_bar_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:oscilloscope/oscilloscope.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = NotificationService.flutterLocalNotificationsPlugin;
//osciloscopio
  //Timer? _timer;

  @override
  initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    //osciloscopio
    //_timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
  }

  //osci
  // @override
  // void dispose() {
  //   _timer!.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(0, 255, 255, 255)));

    // final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    // final currUser = FirebaseAuth.instance.currentUser;
    // final isLoggedIn = currUser != null;
    // if (isLoggedIn) {
    //   GlobalConstants.currentUser = UserData.fromFirebase(currUser);
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YourPulse',
      theme: ThemeData(
        textTheme: TextTheme(bodyText1: TextStyle(color: ColorConstants.textColor)),
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final isLoggedIn = FirebaseAuth.instance.currentUser != null;
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Fitness',
  //     theme: ThemeData(
  //       textTheme: TextTheme(bodyText1: TextStyle(color: ColorConstants.textColor)),
  //       fontFamily: 'NotoSansKR',
  //       scaffoldBackgroundColor: Colors.white,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     home: isLoggedIn ? TabBarPage() : OnboardingPage(),
  //   );
  // }

  Future selectNotification(String? payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}