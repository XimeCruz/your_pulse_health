import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/screens/common_widgets/pulse_button.dart';
import 'package:your_pulse_health/screens/reminder/bloc/reminder_bloc.dart';
import 'package:your_pulse_health/screens/reminder/widget/reminder_content.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReminderBloc>(
      create: (context) => ReminderBloc(),
      child: BlocBuilder<ReminderBloc, ReminderState>(
        buildWhen: (_, currState) => currState is ReminderInitial,
        builder: (context, state) {
          return Scaffold(
            body: _buildContext(context),
            appBar: AppBar(
              centerTitle: false,
              titleSpacing: 0,
              title: Text(
                TextConstants.reminder,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorConstants.primaryColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: PulseButton(
                title: TextConstants.save,
                onTap: () {
                  final bloc = BlocProvider.of<ReminderBloc>(context);
                  bloc.add(OnSaveTappedEvent());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  BlocConsumer<ReminderBloc, ReminderState> _buildContext(
      BuildContext context) {
    return BlocConsumer<ReminderBloc, ReminderState>(
      buildWhen: (_, currState) => currState is ReminderInitial,
      builder: (context, state) {
        if (state is ReminderInitial) {
          BlocProvider.of<ReminderBloc>(context).add(
            ReminderNotificationTimeEvent(dateTime: DateTime.now()),
          );
        }
        return ReminderContent();
      },
      listenWhen: (_, currState) => currState is OnSaveTappedState,
      listener: (context, state) async {
        await showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Se guardó el recordatorio"),
                actions: [
                  TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Aceptar"))
                ],
              );
            }
        );
        Navigator.of(context).pop();
      },
    );
  }
}
