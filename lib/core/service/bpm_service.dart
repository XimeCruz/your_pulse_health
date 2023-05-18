import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BpmService{

  final db = FirebaseFirestore.instance;

  saveBpmPressure(PressureData pressureData) async{
    try{
      await db.collection('bpm').add(pressureData.toJson());
    }
    catch(e){
      print(e);
    }

  }
  Future<List <PressureData>> getBpmPressure({DateTime? start, DateTime? end, String? typeOrd}) async{

    try{
      var query = db.collection('bpm').where('userId',isEqualTo: GlobalConstants.currentUser.uuid).orderBy('date',descending: true);
      if (start != null && end != null){
        query = query.where('date',isGreaterThanOrEqualTo: Timestamp.fromDate(start)).where('date', isLessThanOrEqualTo: Timestamp.fromDate(end));
        // if (typeOrd != null){
        //   query = query.where('date',isGreaterThanOrEqualTo: Timestamp.fromDate(start)).where('date', isLessThanOrEqualTo: Timestamp.fromDate(end)).orderBy('date',descending: true);
        // }
      }
      if (typeOrd != null){
        query = query.orderBy('date',descending: true);
      }

      var list = await query.get();
      
      List <PressureData> listPressureData = [];
      for (var doc in list.docs){
        listPressureData.add(PressureData.fromJson(doc.data()));
      }
      return listPressureData;
    }
    catch(e){
      print(e);
      return [];
    }
  }
  

}