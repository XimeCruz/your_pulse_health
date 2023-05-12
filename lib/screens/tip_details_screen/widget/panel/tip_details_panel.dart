import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:flutter/material.dart';
import 'package:your_pulse_health/screens/tip_details_screen/bloc/tipdetails_bloc.dart';
import 'package:your_pulse_health/screens/tip_details_screen/widget/panel/tip_tag.dart';

class TipDetailsPanel extends StatelessWidget {
  final TipData tip;

  TipDetailsPanel({required this.tip});

  @override
  Widget build(BuildContext context) {
    return _createPanelData(context);
  }

  Widget _createPanelData(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        _createRectangle(),
        const SizedBox(height: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHeader(),
              const SizedBox(height: 30),
              _createWorkoutData(context),
              SizedBox(height: 5),
              _createContentTip(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createRectangle() {
    return Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        tip.title!,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createWorkoutData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          TipTag(
              icon: PathConstants.timeTracker,
              content: "15:00"
            //content: "${_getExerciseTime()}:00",
          ),
          const SizedBox(width: 15),
          // TipTag(
          //   icon: PathConstants.exerciseTracker,
          //   content:
          //   '${tip.exerciseDataList!.length} ${TextConstants.exercisesLowercase}',
          // ),
        ],
      ),
    );
  }

  int _getExerciseTime() {
    int time = 0;
    final List<int?> exerciseList =
    tip.exerciseDataList!.map((e) => e.minutes).toList();
    exerciseList.forEach((e) {
      time += e!;
    });
    return time;
  }

  Widget _createExerciesList() {
    return BlocBuilder<TipDetailsBloc, TipDetailsState>(
      buildWhen: (_, currState) => currState is ReloadTipDetailsState,
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // child: ExercisesList(
            //   exercises: tip.exerciseDataList ?? [],
            //   workout: tip,
            // ),
          ),
        );
      },
    );
  }

  Widget _createContentTip(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 470,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Text(
                  tip.textTip?? ""
              ),
            ],
          ),
        ),

        // child: ExercisesList(
        //   exercises: tip.exerciseDataList ?? [],
        //   workout: tip,
        // ),
      ),
    );
  }

}


