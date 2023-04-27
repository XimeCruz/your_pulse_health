import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/exercise_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';
import 'package:your_pulse_health/screens/common_widgets/pulse_button.dart';
import 'package:your_pulse_health/screens/start_workout/page/start_workout_page.dart';
import 'package:your_pulse_health/screens/workout_details_screen/bloc/workoutdetails_bloc.dart';
import 'package:your_pulse_health/screens/workout_details_screen/widget/workout_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:your_pulse_health/core/extensions/list_extension.dart';

class WorkoutDetailsPage extends StatelessWidget {

  final WorkoutData workout;

  WorkoutDetailsPage({required this.workout});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<WorkoutDetailsBloc> _buildContext(BuildContext context) {
    final workoutDetailsBloc = WorkoutDetailsBloc();
    return BlocProvider<WorkoutDetailsBloc>(
      create: (context) => workoutDetailsBloc,
      child: BlocConsumer<WorkoutDetailsBloc, WorkoutDetailsState>(
        buildWhen: (_, currState) => currState is WorkoutDetailsInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<WorkoutDetailsBloc>(context);
          bloc.add(WorkoutDetailsInitialEvent(workout: workout));
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: PulseButton(
                  title: workout.currentProgress == 0
                      ? TextConstants.start
                      //: TextConstants.continueT,
                      : TextConstants.start,
                  // onTap: () {
                  //   ExerciseData? exercise = workout.exerciseDataList.firstWhereOrNull((element) => element.progress < 1);
                  //   if (exercise == null) exercise = workout.exerciseDataList.first;
                  //   int exerciseIndex = workout.exerciseDataList.indexOf(exercise);
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //         builder: (_) => BlocProvider.value(
                  //               value: BlocProvider.of<WorkoutDetailsBloc>(context),
                  //               child: StartWorkoutPage(
                  //                 exercise: exercise!,
                  //                 currentExercise: exercise,
                  //                 nextExercise: exerciseIndex + 1 < workout.exerciseDataList.length ? workout.exerciseDataList[exerciseIndex + 1] : null,
                  //               ),
                  //             )),
                  //   );
                  // },
                  onTap: () {
                    final index = workout.currentProgress ==
                        workout.exerciseDataList!.length
                        ? 0
                        : workout.currentProgress;
                    bloc.add(StartTappedEvent(index: index));
                  },
                ),
              ),
              body: WorkoutDetailsContent(workout: workout)
          );
        },
        listenWhen: (_, currState) =>
                  currState is BackTappedState ||
                  currState is WorkoutExerciseCellTappedState ||
                  currState is StartTappedState,
        listener: (context, state) async {
          if (state is BackTappedState) {
            Navigator.pop(context);
          } else if (state is StartTappedState) {
                final workout = state.isReplace
                    ? await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<WorkoutDetailsBloc>(context),
                      child: StartWorkoutPage(
                        workout: state.workout,
                        index: state.index,
                      ),
                    ),
                  ),
                )
                  : await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<WorkoutDetailsBloc>(context),
                      child: StartWorkoutPage(
                      workout: state.workout,
                      index: state.index,
                      ),
                    ),
                  ),
              );
              if (workout is WorkoutData) {
                BlocProvider.of<WorkoutDetailsBloc>(context).add(
                        WorkoutDetailsInitialEvent(workout: workout),
                );
            }
          }
        },
      ),
    );
  }
}
