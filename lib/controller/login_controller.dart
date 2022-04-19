import 'package:rental_santuy/data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginController {
  Map<String, dynamic> dataLogin = {};

  bool isLogin = false;

  String? nama;

  String? nim;

  String? username;

  void saveToLocal(Map<String, dynamic> dataLogin, bool isLogin) async {
    this.dataLogin = dataLogin;
    final pref = await SharedPreferences.getInstance();
    await pref.setString('username', dataLogin['username']);
    await pref.setString('nama', dataLogin['nama']);
    await pref.setString('nim', dataLogin['Nim']);
    await pref.setBool('isLogin', isLogin);
    print("Data disimpan ${isLogin}");
  }

  void getDataFromLocal() async {
    final pref = await SharedPreferences.getInstance();
    print(pref.getString('username'));
    username = pref.getString('username');
    print(username);
    nama = pref.getString('nama');
    nim = pref.getString('nim');
    isLogin = pref.getBool('isLogin') ?? false;
  }

  bool auth(String username, String password) {
    for (int i = 0; i < DummyData.data.length; i++) {
      if (username == DummyData.data[i]['username']) {
        if (password == DummyData.data[i]['password']) {
          saveToLocal(DummyData.data[i], true);
        }
      }
    }
    isLogin = false;
    return isLogin;
  }

  bool logout() {
    isLogin = false;
    return isLogin;
  }

  void setIsLogin(isLogin) {
    this.isLogin = isLogin;
  }

  void setDataLogin(Map<String, dynamic> dataLogin) {
    this.dataLogin = dataLogin;
  }

  String? getNama() {
    return dataLogin['nama'];
  }

  String getNim() {
    return dataLogin['Nim'];
  }

  String getUsername() {
    return dataLogin['username'];
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class LoginController extends StatelessWidget {
//   LoginController({Key? key}) : super(key: key);

//   Map<String, dynamic> dataLogin = {};
//   bool isLogin = false;
//   String? nama;
//   String? nim;
//   String? username;

//   void saveToLocal() async {
//     final pref = await SharedPreferences.getInstance();
//     await pref.setString('username', getUsername());
//     await pref.setString('nama', getNama());
//     await pref.setString('nim', getNim());
//     await pref.setBool('isLogin', isLogin);
//     print("Data disimpan ${isLogin}");
//   }

//   void getDataFromLocal() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     final pref = await SharedPreferences.getInstance();
//     username = pref.getString('username');
//     nama = pref.getString('nama');
//     nim = pref.getString('nim');
//     isLogin = pref.getBool('isLogin') ?? false;
//   }

//   bool auth(String username, String password) {
//     for (int i = 0; i < DummyData.data.length; i++) {
//       if (username == DummyData.data[i]['username']) {
//         if (password == DummyData.data[i]['password']) {
//           dataLogin = DummyData.data[i];
//           isLogin = true;
//           saveToLocal();
//         }
//       }
//     }
//     isLogin = false;
//     return isLogin;
//   }

//   bool logout() {
//     isLogin = false;
//     return isLogin;
//   }

//   String getNama() {
//     return dataLogin['nama'].toString();
//   }

//   String getNim() {
//     return dataLogin['Nim'];
//   }

//   String getUsername() {
//     return dataLogin['username'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class LoginController extends StatefulWidget {
//   LoginController({Key? key}) : super(key: key);

//   @override
//   State<LoginController> createState() => _LoginControllerState();
// }

// class _LoginControllerState extends State<LoginController> {
//   Map<String, dynamic> dataLogin = {};

//   bool isLogin = false;

//   String? nama;

//   String? nim;

//   String? username;

//   void saveToLocal() async {
//     final pref = await SharedPreferences.getInstance();
//     await pref.setString('username', getUsername());
//     await pref.setString('nama', getNama());
//     await pref.setString('nim', getNim());
//     await pref.setBool('isLogin', isLogin);
//     print("Data disimpan ${isLogin}");
//   }

//   void getDataFromLocal() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     final pref = await SharedPreferences.getInstance();
//     username = pref.getString('username');
//     nama = pref.getString('nama');
//     nim = pref.getString('nim');
//     isLogin = pref.getBool('isLogin') ?? false;
//   }

//   bool auth(String username, String password) {
//     for (int i = 0; i < DummyData.data.length; i++) {
//       if (username == DummyData.data[i]['username']) {
//         if (password == DummyData.data[i]['password']) {
//           dataLogin = DummyData.data[i];
//           isLogin = true;
//           saveToLocal();
//         }
//       }
//     }
//     isLogin = false;
//     return isLogin;
//   }

//   bool logout() {
//     isLogin = false;
//     return isLogin;
//   }

//   String getNama() {
//     return dataLogin['nama'].toString();
//   }

//   String getNim() {
//     return dataLogin['Nim'];
//   }

//   String getUsername() {
//     return dataLogin['username'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

LoginController login = LoginController();
