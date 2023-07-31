import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MyMarquee extends StatelessWidget {
  final String text;
  final bool mobile;
  const MyMarquee({required this.mobile, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
          thickness: 8,
        ),
        SizedBox(height: mobile ? 1 : 8),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: mobile ? 35 : 70,
          child: Marquee(
              velocity: 35.0,
              text: text,
              //'TECHNOLOGY. SKIING. MUSIC. JOURNALING. FINANCE. BILLIARDS. SKYDIVING. ALGORITHMIC TRADING. BASKETBALL. GUITAR. MOUNTAIN BIKING. SCUBA DIVING. MEDITATION. ART. GOLF. CODING. HIKING. TENNIS. SURFING. POKER. READING. COOKING. MACROECONOMICS. YOGA. FRENCH. DANCING.',
              style: TextStyle(
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w900,
                  fontSize: mobile ? 20 : 50)),
        ),
        const Divider(
          color: Colors.black,
          thickness: 8,
        ),
      ],
    );
  }
}
