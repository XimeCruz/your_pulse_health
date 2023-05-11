part of 'tipdetails_bloc.dart';

@immutable
abstract class TipDetailsState {}

class TipDetailsInitial extends TipDetailsState {}

class BackTappedState extends TipDetailsState {}

class TipExerciseCellTappedState extends TipDetailsState {
  final TipData tip;
  final int index;

  TipExerciseCellTappedState({
    required this.tip,
    required this.index,
  });
}

class ReloadTipDetailsState extends TipDetailsState {
  final TipData tip;

  ReloadTipDetailsState({
    required this.tip,
  });
}

class StartTappedState extends TipDetailsState {
  final TipData tip;
  final int index;
  final bool isReplace;

  StartTappedState({
    required this.tip,
    required this.index,
    required this.isReplace,
  });
}
