import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maleda/routes/routed.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    bool show = true;
    if (deviceWidth <= 385) {
      show = false;
    }
    // print("Device Width : ${deviceWidth}");
    return SizedBox(
      height: 170,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Maleda Market",
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Pure Ethiopian Food"),
                    // Text("Pure Ethiopian Food"),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Text(
                  "People's Choice",
                  style: TextStyle(color: Colors.orange),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.star,
                  size: 18,
                  color: Colors.orange,
                ),
                const SizedBox(width: 4),
                const Text(
                  "200+ Users",
                  style: TextStyle(color: Colors.orange),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Visibility(
                  visible: show,
                  child: const InfoCard(
                    svgSrc: "assets/icons/delivery.svg",
                    title: "In-Store",
                    subtitle: "Pickup",
                  ),
                ),
                Visibility(
                  visible: show,
                  child: const SizedBox(width: 16),
                ),
                Visibility(
                  visible: show,
                  child: const InfoCard(
                    svgSrc: "assets/icons/clock.svg",
                    title: "15",
                    subtitle: "Minutes Max",
                  ),
                ),
                Visibility(
                  visible: show,
                  child: const SizedBox(width: 24),
                ),
                Visibility(
                  visible: show,
                  child: const Spacer(),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    fixedSize: const Size(125, 40),
                    side: const BorderSide(color: Colors.white),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.cart_fill,
                            size: 20,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Cart".toUpperCase(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String svgSrc, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(svgSrc),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.green,
              ),
            )
          ],
        )
      ],
    );
  }
}
