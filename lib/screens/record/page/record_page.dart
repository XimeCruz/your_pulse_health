import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/service/bpm_service.dart';
import 'package:your_pulse_health/screens/record/bloc/record_bloc.dart';
import 'package:your_pulse_health/screens/record/widget/record_content.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          "Historial",
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
          // onPressed: () {
          //   blocTabBar.add(
          //       TabBarItemTappedEvent(index: blocTabBar.currentIndex = 1));
          // },
        ),
      ),
    );
  }

  BlocProvider<RecordBloc> _buildContext(BuildContext context) {
    return BlocProvider<RecordBloc>(
      create: (BuildContext context) => RecordBloc(BpmService())..add(GetPressureEvent()),
      child: BlocConsumer<RecordBloc, RecordState>(
        builder: (context, state) {
          if (state is PressureDataState){
            return RecordContent(
                pressureData: state.pressuredata
            );
          }
          return Center(
              child: CircularProgressIndicator(),
          );
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
