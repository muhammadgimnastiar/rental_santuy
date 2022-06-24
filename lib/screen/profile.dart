import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/data/vehicle_data.dart' as vehicle;
import 'package:rental_santuy/main.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/modal.dart';

class Profile extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  Profile(this.sharedPrefs, {Key? key}) : super(key: key);
  late CurrentUser user = CurrentUser(sharedPrefs);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String title = "Profile";

  @override
  void initState() {
    widget.user.getDataFromLocal();

    super.initState();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();

    widget.sharedPrefs.clear();
    Navigator.popAndPushNamed(context, "/");
    main();
  }

  List<Map<String, dynamic>> carsList = vehicle.VehicleData.Bicycles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(child: TextLarge(title)),
        actions: const [
          SizedBox(
            width: 24,
          )
        ],
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (() async {
                        showFloatingModalBottomSheet(
                          context: context,
                          builder: (context) => ModalFit(
                            nama: widget.user.nama,
                            nim: widget.user.nim,
                            username: widget.user.username,
                            sharedPrefs: widget.sharedPrefs,
                          ),
                        );
                      }),
                      child: Image.asset(
                        'lib/assets/avatars/Avatar.png',
                        width: 52,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLarge(
                            widget.user.nama,
                            maxLines: 1,
                          ),
                          TextMedium(widget.user.nim),
                          TextMedium(widget.user.username)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const TextMedium(
                  "Akun",
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 16,
                ),
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const TextLargeBold(
                    "Atur Akun",
                  ),
                  onTap: (() async {
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => ModalFit(
                        nama: widget.user.nama,
                        nim: widget.user.nim,
                        username: widget.user.username,
                        sharedPrefs: widget.sharedPrefs,
                        onTap: () {
                          logout();
                        },
                      ),
                    );
                  }),
                )
              ],
            ),
          )),
    );
  }
}
