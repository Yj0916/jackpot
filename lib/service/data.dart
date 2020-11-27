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

Future<String> imageLinkRetrieve(int plantNumber) async{
  final databaseReference = Firestore.instance;
  var future = await databaseReference.collection("PlantData").document("PlantImage").get();
  if(!future.exists){
    return null;
  }
  else{
    String path = future['path'+plantNumber.toString()];
    return path;
  }
}

void RemoveImage(int plantNumber) async{
  final databaseReference = Firestore.instance;
  await databaseReference.collection("PlantData")
      .document("PlantImage").updateData({'path'+plantNumber.toString() : null});
}

String waterText(int waterLevel){
  if(waterLevel <30){
    return "물탱크에 물이 얼마 남지 않았어요. 물을 충전해주세요.";
  }
  else if(waterLevel<60){
    return "물이 반정도 차있어요! 조만간 물을 충전해주세요";
  }
  else{
    return "물탱크에 물이 충분히 있어요. 안심하세요!";
  }
}

Future<DocumentSnapshot> statusRetrieve() async{
  final databaseReference = Firestore.instance;
  var future = await databaseReference.collection("PlantData").document("PlantStatus").get();
  return future;
}

Future<DocumentSnapshot> reportRetrieve() async{
  final databaseReference = Firestore.instance;
  var future = await databaseReference.collection("PlantData").document("PlantReport").get();
  return future;
}

List<String> parseText(String text){
  return text.split(',');
}