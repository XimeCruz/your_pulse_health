import 'package:flutter/material.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/data/pressure_data.dart';

class PressureHomeCard extends StatelessWidget {
  final Color color;
  final PressureData pressure;
  final Function() onTap;

  PressureHomeCard({
    required this.color,
    required this.pressure,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //padding: const EdgeInsets.all(0),
        padding: const EdgeInsets.only(
          left: 20,
          top: 10,
          right: 12,
        ),
        height: 90,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.timer, color: ColorConstants.white,),
                        const SizedBox(width: 5),
                        Text(
                          "${pressure.date}",
                          style: TextStyle(
                            color: ColorConstants.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${pressure.bpm} BPM",
                          style: TextStyle(
                            color: ColorConstants.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {  },
                          child: Text ("${pressure.status}",
                            style: TextStyle(
                              color: ColorConstants.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
