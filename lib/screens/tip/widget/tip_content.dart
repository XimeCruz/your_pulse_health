import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:your_pulse_health/screens/home/widget/home_exercises_card.dart';

import 'package:your_pulse_health/screens/tip/bloc/tip_bloc.dart';
import 'package:your_pulse_health/screens/tip/widget/tip_tips_card.dart';
import 'package:your_pulse_health/screens/tip_details_screen/page/tip_details_page.dart';
import 'package:your_pulse_health/screens/workout_details_screen/page/workout_details_page.dart';

class TipContent extends StatelessWidget {

  const TipContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createTipBody(context),
    );
  }

  Widget _createTipBody(BuildContext context) {
    final bloc = BlocProvider.of<TipBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _circleWelcomeTip(context),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //     child: Text('Consejos de salud',
          //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          //   ),
          // ),
          const SizedBox(height: 15),
          Container(
            height: 500,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: DataConstants.tips
                  .map(
                    (e) => _createTipCard(e,context),
              )
                  .toList(),
            ),
            // child: ListView(
            //   scrollDirection: Axis.vertical,
            //   children: [
            //     const SizedBox(height: 5),
            //     WorkoutCard(
            //         color: ColorConstants.armsColor,
            //         workout: DataConstants.workouts[1],
            //         onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //             builder: (_) => WorkoutDetailsPage(
            //               workout: DataConstants.workouts[2],
            //             )))),
            //     const SizedBox(height: 15),
            //     WorkoutCard(
            //         color: ColorConstants.armsColor,
            //         workout: DataConstants.workouts[1],
            //         onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //             builder: (_) => WorkoutDetailsPage(
            //               workout: DataConstants.workouts[2],
            //             )))),
            //     const SizedBox(height: 15),
            //     WorkoutCard(
            //         color: ColorConstants.armsColor,
            //         workout: DataConstants.workouts[1],
            //         onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //             builder: (_) => WorkoutDetailsPage(
            //               workout: DataConstants.workouts[2],
            //             )))),
            //     const SizedBox(width: 20),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }

  Widget _createTipCard(TipData tipData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20,left: 20,right: 20),
      child: TipHomeCard(
          color: ColorConstants.armsColor,
          tip: tipData,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TipDetailsPage(
                tip: tipData,
              )))
      ),
    );
  }

}

  Widget _circleWelcomeTip(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
            width: double.infinity,
            height: 120,
            padding: new EdgeInsets.all(10.0),
            child: Card (
              margin: EdgeInsets.all(10),
              color: ColorConstants.primaryColor,
              shadowColor: Colors.blueGrey,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   ListTile(
                    title: Text(
                      TextConstants.beginTitleHome,
                      style: TextStyle(fontSize: 20,color: ColorConstants.white),
                    ),
                    subtitle: Text(
                      TextConstants.beginsubTitleHome,
                      style: TextStyle(color: ColorConstants.reportColor)),
                    trailing: Container(
                      child: Image(
                        image: AssetImage(PathConstants.iconBeginPressure),
                        height: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      );
    }
