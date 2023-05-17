import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/service/bpm_service.dart';
import 'package:your_pulse_health/screens/bluetooth_config/bloc/bluetooth_bloc.dart';
import 'package:your_pulse_health/screens/bluetooth_config/widget/bluetooth_content.dart';
import 'package:your_pulse_health/screens/tab_bar/page/tab_bar_page.dart';

class BluetoothPage extends StatelessWidget {
  final BluetoothDevice server;

  const BluetoothPage({Key? key, required this.server}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final serverName = server.name ?? "Desconocido";

    return Scaffold(
      body: _buildContext(context),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          serverName,
          style: TextStyle(color: ColorConstants.primaryColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstants.primaryColor,
          ),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarPage()));
          },
          // onPressed: () {
          //   blocTabBar.add(
          //       TabBarItemTappedEvent(index: blocTabBar.currentIndex = 1));
          // },
        ),
      ),
    );
  }

  BlocProvider<BluetoothBloc> _buildContext(BuildContext context) {
    return BlocProvider<BluetoothBloc>(
      create: (BuildContext context) => BluetoothBloc(BpmService()),
      child: BlocConsumer<BluetoothBloc,BluetoothServiceState>(
        buildWhen: (_, currState) =>
        currState is BluetoothInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<BluetoothBloc>(context);
          if (state is BluetoothInitial) {
            bloc.add(BluetoothInitialEvent());
          }
          return BluetoothContent(server: server );
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
