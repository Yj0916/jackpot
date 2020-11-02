import 'package:jackpot/apiKey.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart' ;

//search plant from plantList
Future<List<PlantInfo>> searchPlantList(String text) async
{
  String Planturl = "http://api.nongsaro.go.kr/service/garden/gardenList";
  String sType = "sCntntsSj";
  String requestUrl = Planturl+"?apiKey="+plantApiKey+"&sType="+sType+"&sText="+text;
  Response response = await Dio().get(requestUrl);

  List<PlantInfo> returnList = new List<PlantInfo>();

  var xmlDoc = XmlDocument.parse(response.toString());
  var itemList = xmlDoc.findAllElements('item');
  //var contentsSubjects = itemList.map((node) => node.findElements('cntntsSj').single.text);
  //var contentsNo = itemList.map((node) => node.findElements('cntntsNo').single.text);
  for (var item in itemList) {
    String subject = item.findElements('cntntsSj').single.text;
    String number = item.findElements('cntntsNo').single.text;
    String fileCour = item.findElements('rtnFileCours').single.text;
    var filecourList = fileCour.split('|');
    String fileNm = item.findElements('rtnStreFileNm').single.text;
    var fileNmList = fileNm.split('|');
    returnList.add(PlantInfo(subject, number,filecourList[0],fileNmList[0]));
  }
  return returnList;
}

//get plant detail Info and Image
Future<PlantInfo> getPlantDetail(PlantInfo plant) async {
  String Planturl = "http://api.nongsaro.go.kr/service/garden/gardenDtl";
  String requestUrl = Planturl + "?apiKey=" + plantApiKey + "&cntntsNo=" +
      plant.plantCode;
  Response response = await Dio().get(requestUrl);
  var xmlDoc = XmlDocument.parse(response.toString());
  var itemList = xmlDoc.findAllElements('item');
  for(var item in itemList){
    String fncltyInfo = item.findElements('fncltyInfo').single.text;
    plant.fncltyInfo  = fncltyInfo;
    print(fncltyInfo);
  }
  //parse information
  print(requestUrl);
  return plant;
}

class PlantInfo
{
  String plantName;
  String plantCode;
  String rtnFileCours;
  String rtnStreFileNm;
  String fncltyInfo;

  PlantInfo(String subject, String number,String cour,String Nm){
    this.plantName = subject;
    this.plantCode = number;
    this.rtnFileCours = cour;
    this.rtnStreFileNm = Nm;
  }
}
