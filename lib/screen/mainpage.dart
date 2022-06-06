import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/main.dart';
import 'package:rental_santuy/screen/bicycles.dart';
import 'package:rental_santuy/screen/homepage.dart';
import 'package:rental_santuy/screen/profile.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/widget/modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  MainPage(this.sharedPrefs, {Key? key}) : super(key: key);
  late CurrentUser current = CurrentUser(sharedPrefs);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> screeen = [
    HomePage(widget.sharedPrefs),
    Profile(widget.sharedPrefs)
  ];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(
          context,
          '/motors',
          arguments: message,
        );
        showFloatingModalBottomSheet(
            context: context,
            builder: (context) => ModalFitNotif(
                  nama: message.notification?.title,
                  nim: message.notification?.body,
                  username: message.notification?.body,
                ));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      showFloatingModalBottomSheet(
          context: context,
          builder: (context) => ModalFitNotif(
                nama: message.notification?.title,
                nim: message.notification?.body,
                username: message.notification?.body,
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screeen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          onTap: _setScreen,
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.greySld,
          unselectedItemColor: MyColors.blueSoft2,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_mini),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
