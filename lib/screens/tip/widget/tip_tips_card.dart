
import 'package:flutter/material.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:your_pulse_health/screens/tip_details_screen/page/tip_details_page.dart';

class TipHomeCard extends StatelessWidget {
  final Color color;
  final TipData tip;
  final Function() onTap;

  TipHomeCard({
    required this.color,
    required this.tip,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(0),
        // padding: const EdgeInsets.only(
        //   left: 20,
        //   top: 10,
        //   right: 12,
        // ),
        height: 320,
        width: screenWidth * 0.6,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15),
        //   color: color,
        // ),
        child: Stack(
          children: [
            buildImageInteractionCard(context)
          ],
        ),
      ),
    );
  }

  Widget buildImageInteractionCard(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    color: ColorConstants.tipCardsColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        Stack(
          children: [
            Ink.image(
              image: AssetImage(
                  "${tip.image}"
              ),
              height: 170,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 16,
              right: 16,
              left: 16,
              child: Text(
                "${tip.title}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10).copyWith(bottom: 0),
          child: Text(
            "${tip.description}",
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Text('Leer Mas'),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => TipDetailsPage(
                      tip: tip,
                    )))
            ),
          ],
        )
      ],
    ),
  );

}
