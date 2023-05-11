part of 'tipdetails_bloc.dart';

@immutable
abstract class TipDetailsEvent {}

class BackTappedEvent extends TipDetailsEvent {}

class TipDetailsInitialEvent extends TipDetailsEvent {
  final TipData tip;

  TipDetailsInitialEvent({
    required this.tip,
  });
}

class StartTappedEvent extends TipDetailsEvent {
  final TipData? tip;
  final int? index;
  final bool isReplace;

  StartTappedEvent({
    this.tip,
    this.index,
    this.isReplace = false,
  });
}
