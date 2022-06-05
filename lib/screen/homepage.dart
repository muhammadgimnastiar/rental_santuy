import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/Icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rental_santuy/screen/mainpage.dart' as user;

class HomePage extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  HomePage(
    this.sharedPrefs, {
    Key? key,
  }) : super(key: key);
  late CurrentUser user = CurrentUser(sharedPrefs);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.user.getDataFromLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? _user = FirebaseAuth.instance.currentUser;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextLargeBold(
                        "Hi, ${widget.user.nama}",
                        size: 24,
                        spacing: 2,
                      ),
                      const TextMedium("Jl. Telogomas, 65144"),
                    ],
                  ),
                ),
                Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: MyColors.greySld)),
                  child: const Icon(
                    Icons.search,
                    color: MyColors.greySld,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //Banner
            SizedBox(
              height: width * 0.38,
              width: width,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) =>
                      Image.asset('lib/assets/banner/promo$index.png'),
                  separatorBuilder: (_, index) => const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                  itemCount: 2),
            ),
            const SizedBox(height: 32),
            //categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TextLarge("All Categories"),
                TextMedium("See all")
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconCategories(
                  'lib/assets/kendaraan/car.png',
                  color: MyColors.redSoft,
                  label: "Cars",
                  onTap: () {
                    Navigator.pushNamed(context, "/car");
                  },
                ),
                IconCategories(
                  'lib/assets/kendaraan/motor.png',
                  color: MyColors.blueSoft,
                  label: "Motors",
                  onTap: () {
                    Navigator.pushNamed(context, '/motors');
                  },
                ),
                IconCategories(
                  'lib/assets/kendaraan/bicycle.png',
                  color: MyColors.blueSoft2,
                  label: "Bicycles",
                  onTap: () {
                    Navigator.pushNamed(context, '/bicycles');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [TextLarge("Recomended"), TextMedium("See All")],
            ),
            const SizedBox(
              height: 24,
            ),

            RecommendedCard(width: width),
            RecommendedCard(width: width)
          ]),
        ),
      ),
    );
  }
}

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    Key? key,
    required this.width,
    this.radius = const Radius.circular(99),
    this.radius2 = const Radius.circular(20),
  }) : super(key: key);

  final double width;
  final Radius radius;
  final Radius radius2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: width * 0.38,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: width * 0.38,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: radius,
                      bottomRight: radius,
                      topLeft: radius2,
                      bottomLeft: radius2),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('lib/assets/banner/rent.jpeg'))),
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 16,
                  ),
                  TextLargeBold(
                    "Layanan Lepas kunci",
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextMedium(
                    "Start IDR.100K",
                    fontSize: 14,
                  ),
                  TextMedium(
                    "Diskon Up to 50%",
                    color: MyColors.danger,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
