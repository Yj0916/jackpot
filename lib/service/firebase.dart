import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jackpot/service/plantInfo.dart';

void createRecord() async {
  final databaseReference = Firestore.instance;

  await databaseReference.collection("books")
      .document("2")
      .setData({
    'title': 'Mastering Flutter',
    'description': 'Programming Guide for Dart'
  });

  DocumentReference ref = await databaseReference.collection("books")
      .add({
    'title': 'Flutter in Action',
    'description': 'Complete Programming Guide to learn Flutter'
  });
  print(ref.documentID);
}

/*Plant water Cycle Save*/

void settingSave( double waterLevel ,double fanLevel,double ledLevel ) async{
  final databaseReference = Firestore.instance;
  await databaseReference.collection("PlantData")
      .document("PlantCycle")
      .updateData({
    'FanLevel': fanLevel,
    'LedLevel': ledLevel,
    'WaterCycle': waterLevel
  });
}

/*Retrieve plant Cycle info*/

Future<DocumentSnapshot> settingRetrieve() async{
  final databaseReference = Firestore.instance;
  var fan,led,water;
  var future = null;
  future = await databaseReference.collection("PlantData").document("PlantCycle").get();
  return future;
}

/*
Future<PlantInfo> getDisplayInfo() async{
  final databaseReference = Firestore.instance;
  var future = await databaseReference.collection("PlantData").document("PlantInfo").get();
  if(!future.exists){
    PlantInfo plant =  PlantInfo('test','test','test','test');
    plant.saved = false;
    return plant;
  }
  else{
    PlantInfo plant = PlantInfo(future['plantName'], future['plantCode'], future['rtnFileCours'], future['rtnStreFileNm']);
    plant.fncltyInfo = future['fncltyInfo'];
    print('getInfo!');
    return plant;
  }
}
 */
Future<PlantInfo> getDisplayInfo() async{
  final databaseReference = Firestore.instance;
  var future = await databaseReference.collection("PlantData").document("PlantInfo").get();
  if(!future.exists){
    return null;
  }
  else{
    PlantInfo plant = PlantInfo(future['plantName'], future['plantCode'], future['rtnFileCours'], future['rtnStreFileNm']);
    plant.fncltyInfo = future['fncltyInfo'];
    print('getInfo!');
    return plant;
  }
}

void plantSave( PlantInfo info) async{
  print(info.rtnStreFileNm);
  print('inside the function');
  final databaseReference = Firestore.instance;
  await databaseReference.collection("PlantData")
      .document("PlantInfo").setData({
    'plantName': info.plantName,
    'plantCode': info.plantCode,
    'rtnFileCours': info.rtnFileCours,
    'rtnStreFileNm': info.rtnStreFileNm,
    'fncltyInfo': info.fncltyInfo,
  });
  print('save finish');
}

void plantRemove() async{
  final databaseReference = Firestore.instance;
  await databaseReference.collection("PlantData")
      .document("PlantInfo").delete();
}

/*
  await databaseReference.collection("PlantData")
      .document("PlantInfo").setData({
    'plantName': info.plantName,
    'plantCode': info.plantCode,
    'rtnFileCours': info.rtnFileCours,
    'rtnStreFileNm': info.rtnStreFileNm,
    'fncltyInfo': info.fncltyInfo,
  });
 */