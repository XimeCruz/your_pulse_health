import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
//import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';


class PdfReportService {
  Future<Uint8List> createPdf(){
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          build: (pw.Context context){
            return pw.Center(child: pw.Text("Hello World"));

          }
      ),
    );
    return pdf.save();
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    if(await _checkPermission()){
      final output = await getTemporaryDirectory();
      //var filePath = "${output.path}/$fileName.pdf";
      var filePath = "${await _getSavedDir()}/$fileName.pdf";
      final file = File(filePath);
      await file.writeAsBytes(byteList);
      //await OpenDocument.openDocument(filePath: filePath);
      await OpenFile.open(filePath, type: 'application/pdf');
    }
    else {
      print("ocurrio un error");
    }
  }
}

Future<String?> _getSavedDir() async {
  String? externalStorageDirPath;

  if (Platform.isAndroid) {
    try {
      externalStorageDirPath = (await getDownloadsDirectory())?.path;
    } catch (err,_) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
  } else if (Platform.isIOS) {
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;
  }
  return externalStorageDirPath;
}

Future<bool> _checkPermission() async {
  //android 13
  if(Platform.isAndroid){
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if(android.version.sdkInt >=33){
      return true;
    }
  }
  await Permission.storage.request();
  var per=await Permission.storage.request().isGranted;
  if(per){
    return per;
  }
  else{
    await Permission.storage.request();
  }
  return await Permission.storage.request().isGranted;
}