import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/pages/plantRegister2.dart';
import 'package:jackpot/service/data.dart';
import 'package:jackpot/service/plantInfo.dart';
import 'package:jackpot/style.dart' as style;
import 'package:flappy_search_bar/flappy_search_bar.dart';

class PlantRegister extends StatefulWidget {
  @override
  _PlantRegisterState createState() => _PlantRegisterState();
}

class _PlantRegisterState extends State<PlantRegister> {
  List<PlantInfo> plantList = List<PlantInfo>();
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
    return FutureBuilder(
      future: getDisplayInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData == false){
            return Container(
              color: style.backgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20,bottom: 10),
                      child: Text(
                        '식물 등록',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ]),
                  Container(
                    height: 300,
                    child: SearchBar<PlantInfo>(
                        cancellationWidget: Icon(Icons.close),
                        onSearch: searchPlantList,
                        searchBarStyle: SearchBarStyle(
                          backgroundColor: Colors.white,
                        ),
                        iconActiveColor: style.mainBlue,
                        hintText: '식물 이름을 입력해 주세요',
                        placeHolder: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('images/plants.png', width: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Text('식물 관리를 위해서 내 식물을 등록해 주세요!')
                              ],
                            ),
                          ),
                        ),
                        minimumChars: 1,
                        onItemFound: (PlantInfo plant, int index) {
                          return ListTile(
                            title: Text(plant.plantName),
                            subtitle: Text(plant.plantCode),
                            leading: Image.network(
                              'http://www.nongsaro.go.kr/' +
                                  plant.rtnFileCours +
                                  "/" +
                                  plant.rtnStreFileNm,
                              width: 80,
                              height: 80,
                            ),
                            onTap: (){
                              Navigator.pushNamed(context, '/select',arguments: plant);
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          }
          else{
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20,bottom: 10,left: 20,),
                        child: Text(
                          snapshot.data.plantName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ]),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.network(
                        'http://www.nongsaro.go.kr/' +
                            snapshot.data.rtnFileCours +
                            "/" +
                            snapshot.data.rtnStreFileNm,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('정보',style: style.blueText,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(snapshot.data.fncltyInfo,style: style.infoText,),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 30),
                      color: Color(0xfff0f8ff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('water',style: TextStyle(color: style.buttonColor,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                                  Icon(Icons.bubble_chart,color: style.lightBlue,),
                                  Icon(Icons.bubble_chart,color: style.lightBlue,)
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text('light',style: TextStyle(color: style.buttonColor,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.wb_sunny,color: style.mainBlue,),
                                  Icon(Icons.wb_sunny,color: style.mainBlue,),
                                  Icon(Icons.wb_sunny,color: style.mainBlue,),
                                  Icon(Icons.wb_sunny,color: style.lightBlue,),
                                  Icon(Icons.wb_sunny,color: style.lightBlue,)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            plantRemove();
                            Navigator.pushNamed(context, '/index');
                          },
                          child: Container(
                            padding: EdgeInsets.only(top:15,bottom:15,right: 50,left: 50),
                            decoration: BoxDecoration(
                              color: style.buttonColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text('삭제',style: style.settingButtonTextStyle,textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
        }
    }
    );
  }

}
