import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/firebase_options.dart';
import 'package:rental_santuy/screen/bicycles.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:rental_santuy/screen/mainpage.dart';
import 'package:rental_santuy/screen/motors.dart';
import 'package:rental_santuy/screen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  runApp(MyApp(sharedPrefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  MyApp(this.sharedPrefs, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CurrentUser user = CurrentUser(widget.sharedPrefs);
  late StreamSubscription<User?> userFirebase;

  @override
  void initState() {
    super.initState();
    userFirebase = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        print("User is currently sign out");
      } else {
        print("User is sighn in");
      }
    });
  }

  @override
  void dispose() {
    userFirebase.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = widget.sharedPrefs.getBool(Keys.login) ?? false;

    User? _user = FirebaseAuth.instance.currentUser;
    print(_user?.email ?? "Gada");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental',
      initialRoute: isLogin == false
          ? (_user == null)
              ? '/'
              : '/main'
          : '/main',
      routes: {
        "/": (context) => Login(widget.sharedPrefs),
        "/car": (context) => Cars(widget.sharedPrefs),
        "/main": (context) => MainPage(widget.sharedPrefs),
        "/motors": (context) => Motors(widget.sharedPrefs),
        "/bicycles": (context) => Bicycles(widget.sharedPrefs),
        "/signup": (context) => Signup(widget.sharedPrefs),
      },
    );
  }
}
