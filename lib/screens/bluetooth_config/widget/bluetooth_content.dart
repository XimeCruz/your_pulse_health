import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:your_pulse_health/screens/bluetooth_config/bloc/bluetooth_bloc.dart';

class BluetoothContent extends StatefulWidget {
  final BluetoothDevice server;

  const BluetoothContent({
    Key? key, required this.server,
  });

  @override
  State<BluetoothContent> createState() => _BluetoothContentState();

}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _BluetoothContentState extends State<BluetoothContent> {
  static final clientID = 0;
  BluetoothConnection? connection;
  int valuestatebpm = 60;
  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
  new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);
  bool isBPMEnabled = false;
  bool isDisconnecting = false;
  List<GraphDataC> listDataGraph =  [];
  List<GraphDataC> _listDataGraph =  [ GraphDataC(0.0,0.0)];
  double time=0;

  /// variable to store measured BPM value
  //int bpmValue;

  void initState() {
    _listDataGraph = listDataGraph;
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  // @override
  // void initState() {
  //   timer = Timer.periodic(Duration(seconds: 15), (timer) {BlocProvider.of<PressureCameraBloc>(context).add(SaveBpmEvent(pressureBpm: valuestatebpm)); });
  //  cada 15 segundos
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   if(timer!=null){
  //     timer!.cancel();
  //   }
  //   super.dispose();
  // }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createBluetoothBody(context),
    );
  }

  Widget _createBluetoothBody(BuildContext context) {

    final List<Text> list = messages.map((_message) {
      return Text(
              (text) {
            List<String> bpm = _message.text.trim().split("\n");
                // String valor = _message.text.trim();
                // print(valor);
                // print("SALTO");

            // print("vv= ${bpm.length} fin");
            if(bpm.length<=1){
              if(bpm[0]!="0"){
                print("VALOR= ${bpm[0]}");
                List<String> bpmReal= bpm[0].split("=");
                if(bpmReal.length>=2){
                  valuestatebpm = int.parse(bpmReal[1]);
                }else{
                  if(bpm[0].isNotEmpty){
                    if (bpm[0][0]!="B"){
                      if(bpm[0].length==3){
                        time = time +1.0;
                        listDataGraph.add(GraphDataC(time, double.parse(bpm[0])));
                        if (time>100){
                          listDataGraph.removeAt(0);
                        }
                      }
                    }
                  }

                }
              }

            }
            else{
              for(int i=0;i<bpm.length;i++){
                if(bpm[i]!="0"){
                  print("VALOR= ${bpm[i]}");
                  List<String> bpmReal= bpm[i].split("=");
                  if(bpmReal.length>=2){
                    print(bpmReal[1]);
                    valuestatebpm = int.parse(bpmReal[1]);
                  }else{
                    if(bpm[i].isNotEmpty){
                      if (bpm[i][0]!="B"){
                        if(bpm[i].length==3){
                          time = time +1.0;
                          listDataGraph.add(GraphDataC(time, double.parse(bpm[i])));
                          if (time>100){
                            listDataGraph.removeAt(0);
                          }
                        }
                      }
                    }

                  }
                }

              }
            }



            //
            // if(valor[0] == "B"){
            //   print("bpm == "+valor);
            //   if (_message.text.trim().split(" = ")[1].length<=3){
            //
            //   String bpm = _message.text.trim().replaceAll(RegExp(r'[^0-9]'),'');
            //   print("bpm == "+bpm);
            //     valuestatebpm = int.parse(bpm);
            //   }
            //
            // }else{
            //
            //   if(!valor.contains("B") && valor.isNotEmpty){
            //     print(valor);
            //     num? valAux = num.tryParse(_message.text.trim().replaceAll(" ", "")) ;
            //     if(valAux!=null){
            //       num val = valAux;
            //       print("t=${val}");
            //     }
            //   }
            //
            //   List<String> bpm1 = _message.text.trim().split(" = ");
            //
            //
            //   print(val);
            //   if(val>=0 && val<=1000){
            //     print(val);
            //     time = time +1.0;
            //     listDataGraph.add(GraphDataC(time, val));
            //     if (time>100){
            //       listDataGraph.removeAt(0);
            //     }
            //   }
            //   print("data == " +_message.text.trim());
            // }
            // if
            // listDataGraph.add(GraphDataC(1.0,1.0));

            return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
          }(_message.text.trim()),
          style: TextStyle(color: Colors.black));
    }).toList();


    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _valueBPM(context,valuestatebpm),
          const SizedBox(height: 25),
          isBPMEnabled
              ? _graphValueBPM(context)
              : _graphValueBPM2(context),
          Expanded(
            child: Center(
                child: SizedBox.fromSize(
                  size: Size(150, 150), // button width and height
                  child: ClipOval(
                    child: Material(
                      color: ColorConstants.primaryColor, // button color
                      child: InkWell(
                        splashColor: ColorConstants.reportColor,
                        onTap: () =>
                            setState((){

                              isBPMEnabled = !isBPMEnabled;

                              if(!isBPMEnabled){
                                BlocProvider.of<BluetoothBloc>(context).add(SaveBpmEvent(pressureBpm: valuestatebpm));
                              }
                            }),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage(
                                PathConstants.iconButtonPressure,
                              ),
                              width: 30.0,
                              height: 30.0,
                            ),
                            Text(
                              isBPMEnabled ? TextConstants.stopPressure : TextConstants.pushPressure,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ), // text
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _valueBPM(BuildContext context, int valuestatebpm){
    final valuebpm = TextConstants.namePressure;

    final date = DateTime.now();
    final day = date.day;
    final months = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
    final month = months[date.month-1];
    final year = date.year;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      child: Text(isBPMEnabled ? '$valuestatebpm' :"0",
                          style: TextStyle(fontSize: 40)),
                    ),
                    const SizedBox(width: 5),
                    Text('$valuebpm',
                        style: TextStyle(fontSize: 18, )),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              Text('$day $month $year',
                  style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _graphValueBPM(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      //width: 350,
      height: 330,

      child: SfCartesianChart(
        series: <ChartSeries>[
          LineSeries<GraphDataC,double>(
            dataSource: _listDataGraph,
            xValueMapper: (GraphDataC data, _) => data.time,
            yValueMapper: (GraphDataC data, _) => data.data,
          )
        ],
      ),
    );
  }

  Widget _graphValueBPM2(BuildContext context){
    //Osciloscopio
    List<double> traceSine = [];
    double radians = 0.0;

    var sv = sin((radians * pi));

    traceSine.add(sv);
    //traceCosine.add(cv);

    radians += 0.05;
    if (radians >= 2.0) {
      radians = 0.0;
    }

    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.black,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 1.0,
      backgroundColor: ColorConstants.homeBackgroundColor,
      traceColor: Colors.green,
      yAxisMax: 1.0,
      yAxisMin: -1.0,
      dataSet: traceSine,
    );

    // Generate the Scaffold
    return Expanded(flex: 1, child: scopeOne);
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {

        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {

      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
          0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }

  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
class GraphDataC {
  GraphDataC(this.time,this.data);
  final double time;
  final double data;
}





