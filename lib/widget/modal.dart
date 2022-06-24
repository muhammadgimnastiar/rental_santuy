import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rental_santuy/main.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({Key? key, required this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
      ),
    );
  }
}

Future<T> showFloatingModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) => FloatingModal(
            child: child,
          ),
      expand: false);

  return result;
}

class ModalFit extends StatelessWidget {
  const ModalFit(
      {required this.nama,
      required this.nim,
      required this.username,
      required this.sharedPrefs,
      this.onTap,
      Key? key})
      : super(key: key);
  final String? nama;
  final String? nim;
  final String? username;
  final SharedPreferences sharedPrefs;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('lib/assets/avatars/Avatar.png'),
            TextLarge(nama!),
            TextMedium(nim!),
            TextMedium(username!),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
                title: const Text('Logout'),
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.redAccent,
                ),
                // ignore: void_checks
                onTap: onTap),
          ],
        ),
      ),
    ));
  }
}

class ModalFitNotif extends StatelessWidget {
  const ModalFitNotif(
      {required this.title,
      required this.body,
      this.image,
      this.onTap,
      Key? key})
      : super(key: key);
  final String? title;
  final String? body;
  final String? image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(image ?? 'lib/assets/avatars/Avatar.png'),
            const SizedBox(
              height: 12,
            ),
            TextLarge(title!),
            const SizedBox(
              height: 12,
            ),
            TextMedium(body!),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
                title: const Text('Cek Sekarang'),
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.redAccent,
                ),
                // ignore: void_checks
                onTap: onTap),
          ],
        ),
      ),
    ));
  }
}
