import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_pulse_health/data/exercise_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workoutdetails_event.dart';
part 'workoutdetails_state.dart';

class WorkoutDetailsBloc
    extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  WorkoutDetailsBloc() : super(WorkoutDetailsInitial());

  late WorkoutData workout;

  @override
  Stream<WorkoutDetailsState> mapEventToState(
      WorkoutDetailsEvent event,
      ) async* {
    if (event is WorkoutDetailsInitialEvent) {
      workout = event.workout;
      yield ReloadWorkoutDetailsState(workout: workout);
    } else if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is StartTappedEvent) {
      yield StartTappedState(
        workout: event.workout ?? workout,
        index: event.index ?? 0,
        isReplace: event.isReplace,
      );
    }
  }
}
