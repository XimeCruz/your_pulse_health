import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/screens/tab_bar/page/tab_bar_page.dart';
import 'package:your_pulse_health/screens/tip/bloc/tip_bloc.dart';
import 'package:your_pulse_health/screens/tip/widget/tip_content.dart';

class TipPage extends StatelessWidget {
  const TipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          TextConstants.tipsTitleHome,
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

  BlocProvider<TipBloc> _buildContext(BuildContext context) {
    return BlocProvider<TipBloc>(
      create: (BuildContext context) => TipBloc(),
      child: BlocConsumer<TipBloc, TipState>(
        buildWhen: (_, currState) =>
            currState is TipInitial ||
            currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<TipBloc>(context);
          if (state is TipInitial) {
            bloc.add(TipInitialEvent());
            //bloc.add(ReloadDisplayNameEvent());
            //bloc.add(ReloadImageEvent());
          }
          return TipContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
