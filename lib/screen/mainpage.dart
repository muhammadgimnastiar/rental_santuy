import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/main.dart';
import 'package:rental_santuy/screen/homepage.dart';
import 'package:rental_santuy/screen/profile.dart';
import 'package:rental_santuy/screen/transaksi_history.dart';
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
    const TransasksiHistory(),
    Profile(widget.sharedPrefs)
  ];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        showFloatingModalBottomSheet(
            context: context,
            builder: (context) => ModalFitNotif(
                  title: message.notification?.title,
                  body: message.notification?.body,
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
                title: message.notification?.title,
                body: message.notification?.body,
                onTap: () {
                  Navigator.pushNamed(context, "/car");
                },
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
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: "Transaksi"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
