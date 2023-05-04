import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/workout_data.dart';
import 'package:your_pulse_health/screens/common_widgets/pulse_button.dart';
import 'package:your_pulse_health/screens/edit_account/edit_account_screen.dart';
import 'package:your_pulse_health/screens/home/bloc/home_bloc.dart';
import 'package:your_pulse_health/screens/home/widget/home_statistics.dart';
import 'package:your_pulse_health/screens/record/page/record_page.dart';
import 'package:your_pulse_health/screens/report/page/report_page.dart';
import 'package:your_pulse_health/screens/tab_bar/bloc/tab_bar_bloc.dart';
import 'package:your_pulse_health/screens/tip/page/tip_page.dart';
import 'package:your_pulse_health/screens/workout_details_screen/page/workout_details_page.dart';

import 'home_exercises_card.dart';

class HomeContent extends StatelessWidget {
  final List<WorkoutData> workouts;

  const HomeContent({
    required this.workouts,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          _createProfileData(context),
          const SizedBox(height: 35),
          _showStartWorkout(context, bloc),
          const SizedBox(height: 30),
          _createExercisesList(context),
          const SizedBox(height: 25),
          _showProgress(bloc),
        ],
      ),
    );
  }

  Widget _createProfileData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (_, currState) =>
                currState is ReloadDisplayNameState,
                builder: (context, state) {
                  final User? user = FirebaseAuth.instance.currentUser;
                  final displayName = user?.displayName ?? "No Username";
                  // final displayName = state is ReloadDisplayNameState
                  //     ? state.displayName
                  //     : '[name]';
                  return Text(
                    'Hola, $displayName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 2),
              Text(
                TextConstants.checkActivity,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (_, currState) => currState is ReloadImageState,
            builder: (context, state) {
              final photoURL =
              state is ReloadImageState ? state.photoURL : null;
              return GestureDetector(
                child: photoURL == null
                    ? CircleAvatar(
                    backgroundImage: AssetImage(PathConstants.profile),
                    radius: 25)
                    : CircleAvatar(
                    child: ClipOval(
                        child: FadeInImage.assetNetwork(
                            placeholder: PathConstants.profile,
                            image: photoURL,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 120)),
                    radius: 25),
                onTap: () async {
                  await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => EditAccountScreen()));
                  BlocProvider.of<HomeBloc>(context).add(ReloadImageEvent());
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _showStartWorkout(BuildContext context, HomeBloc bloc) {
    return workouts.isEmpty
        ? _createStartWorkout(context, bloc)
        : HomeStatistics();
  }

  Widget _createStartWorkout(BuildContext context, HomeBloc bloc) {
    final blocTabBar = BlocProvider.of<TabBarBloc>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(PathConstants.pressureDo),
                width: 180,
                height: 180,
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 16),
          PulseButton(
            title: TextConstants.startPressure,
            onTap: () {
              blocTabBar.add(
                  TabBarItemTappedEvent(index: blocTabBar.currentIndex = 1));
            },
          ),
        ],
      ),
    );
  }

  Widget _createExercisesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Text(
        //     TextConstants.discoverWorkouts,
        //     style: TextStyle(
        //       color: ColorConstants.textBlack,
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        const SizedBox(height: 5),
        Container(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              WorkoutCard(
                  color: ColorConstants.reportColor,
                  workout: DataConstants.workouts[0],
                  onTap: () =>
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ReportPage()))),
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) =>
                      //         WorkoutDetailsPage(
                      //             workout: DataConstants.workouts[0])))),
              const SizedBox(width: 15),
              WorkoutCard(
                color: ColorConstants.recordsColor,
                workout: DataConstants.workouts[1],
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => RecordPage()))),
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) =>
                    //         WorkoutDetailsPage(
                    //           workout: DataConstants.workouts[1],
                    //         ),
                    //   ),
                    // ),
              const SizedBox(width: 15),
              WorkoutCard(
                color: ColorConstants.tipsColor,
                workout: DataConstants.workouts[2],
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TipPage()))),
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) =>
                    //         WorkoutDetailsPage(
                    //           workout: DataConstants.workouts[2],
                    //         ),
                    //   ),
                    // ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showProgress(HomeBloc bloc) {
    return workouts.isNotEmpty ? _createProgress(bloc) : Container();
  }

  Widget _createProgress(HomeBloc bloc) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Row(
        children: [
          Image(image: AssetImage(PathConstants.progress)),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextConstants.keepProgress,
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(
                  '${TextConstants.profileSuccessful} ${bloc
                      .getProgressPercentage()}% of workouts.',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int getProgressPercentage() {
    final completed = workouts
        .where((w) =>
    (w.currentProgress ?? 0) > 0 && w.currentProgress == w.progress)
        .toList();
    final percent01 =
        completed.length.toDouble() / DataConstants.workouts.length.toDouble();
    final percent = (percent01 * 100).toInt();
    return percent;
  }
}


