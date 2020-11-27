import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jackpot/service/datetime.dart';
import 'package:jackpot/service/data.dart';
import 'package:jackpot/service/weather.dart';
import '../style.dart' as style;
import '../databox.dart';
import 'package:weather_icons/weather_icons.dart';
import 'bluetoothPage.dart';
import 'graphPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int waterlevel = 33;
  int temp = 26;
  int humidity = 81;
  int dust = 13;
  List<bool> isbuttonTouched = [false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FutureBuilder(
          future: weatherInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.hasData == false) {
              return DataBox(Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            color: Color(0xff7c7c7c),
                            size: 15,
                          ),
                          Text(
                            '부산광역시 장전동',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        ' 9월 27일 일요일 오후 22:20',
                        style: TextStyle(color: Color(0xff7c7c7c)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.wb_sunny,
                        size: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('맑음',style: TextStyle(fontSize: 18),),
                          SizedBox(height: 3,),
                          Text('온도     습도',style: TextStyle(fontSize: 10,color: style.greyText),),
                          Text('28C  74%',style: TextStyle(color: style.greyText,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(width: 5,),
                      /*
                        Container(
                          padding: EdgeInsets.only(top:11,left: 10,right: 10,bottom: 11),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors : [Color(0xffe2f7fe), Color(0xfff8faeb)]),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            '봄부터 가을까지 비료를 사용해\n촉촉하게 유지해야해요.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: style.greyText,fontSize: 14),
                          ),
                        ),
                         */
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    padding:
                    EdgeInsets.only(top: 7, bottom: 7, left: 30, right: 30),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffb2d9f9),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      '더보기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),15,7.5);
            }
            else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }
            else{
              return DataBox(Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            color: Color(0xff7c7c7c),
                            size: 15,
                          ),
                          Text(
                            '부산광역시 장전동',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        DateString(),
                        style: TextStyle(color: Color(0xff7c7c7c)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        iconReturn(snapshot.data.weatherConditionCode),
                        size: 45,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(snapshot.data.weatherDescription,style: TextStyle(fontSize: 18),),
                          SizedBox(height: 5,),
                          Text('온도       습도',style: TextStyle(fontSize: 10,color: style.greyText),),
                          Text(WeatherFormat(snapshot.data.temperature.celsius,snapshot.data.humidity),style: TextStyle(color: style.greyText,fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.only(top:11,left: 10,right: 10,bottom: 11),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xffe2f7fe), Color(0xfff8faeb)]),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          '봄부터 가을까지 비료를 사용해\n촉촉하게 유지해야해요.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: style.greyText,fontSize: 14),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    padding:
                    EdgeInsets.only(top: 7, bottom: 7, left: 30, right: 30),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffb2d9f9),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      '더보기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),15,7.5);
            }
          },
        ),
        FutureBuilder(
            future: statusRetrieve(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return DataBox(Column(
                  children: <Widget>[
                    Text('JackPot 상태',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('images/Co2.png',width: 30.0,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5,),
                              Text('미세먼지',style: TextStyle(fontSize: 12,color: style.greyText),),
                            ],
                          ),
                          SizedBox(height: 3,),
                          NumberData(dust,'㎍/m³')
                        ],),
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('images/temp.png',height: 25,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5,),
                              SizedBox(width: 5,),
                              Text('온도',style: TextStyle(fontSize: 12,color: style.greyText),),
                            ],
                          ),
                          SizedBox(height: 3,),
                          NumberData(temp,'℃')
                        ],),
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('images/waterdrop.png',height:25,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5,),
                              SizedBox(width: 5,),
                              Text('습도',style: TextStyle(fontSize: 12,color: style.greyText),),
                            ],
                          ),
                          SizedBox(height: 3,),
                          NumberData(humidity,'%'),
                        ],),
                      ],
                    ),
                  ],
                ),7.5,7.5);
              }
              else{
                waterlevel =  snapshot.data['waterLevel'];
                humidity = snapshot.data['humidity'];
                temp = snapshot.data['temperature'];
                return DataBox(Column(
                  children: <Widget>[
                    Text('JackPot 상태',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('images/Co2.png',width: 30.0,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5,),
                              Text('미세먼지',style: TextStyle(fontSize: 12,color: style.greyText),),
                            ],
                          ),
                          SizedBox(height: 3,),
                          NumberData(dust,'㎍/m³')
                        ],),
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('images/temp.png',height: 25,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5,),
                              SizedBox(width: 5,),
                              Text('온도',style: TextStyle(fontSize: 12,color: style.greyText),),
                            ],
                          ),
                          SizedBox(height: 3,),
                          NumberData(temp,'℃')
                        ],),
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset('images/waterdrop.png',height:25,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 5,),
                              SizedBox(width: 5,),
                              Text('습도',style: TextStyle(fontSize: 12,color: style.greyText),),
                            ],
                          ),
                          SizedBox(height: 3,),
                          NumberData(humidity,'%'),
                        ],),
                      ],
                    ),
                  ],
                ),7.5,7.5);
              }
        }),
        FutureBuilder(
            future: statusRetrieve(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return DataBox(Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('images/wave.png',height:15,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text('수위')
                      ],
                    ),
                    NumberData(waterlevel,'%'),
                    SizedBox(height: 5,),
                    Text('물탱크에 물이 얼마 남지 않았어요. 물을 충전해주세요.',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
                  ],
                ),7.5,7.5);
              }
              else{
                waterlevel =  snapshot.data['waterLevel'];
                humidity = snapshot.data['humidity'];
                temp = snapshot.data['temperature'];

                return DataBox(Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('images/wave.png',height:15,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text('수위')
                      ],
                    ),
                    NumberData(waterlevel,'%'),
                    SizedBox(height: 5,),
                    Text(waterText(waterlevel),style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
                  ],
                ),7.5,7.5);
              }
            }),
        FutureBuilder(
    future: onOffRetrieve(),
    builder:(BuildContext context, AsyncSnapshot snapshot) {
      if(snapshot.data == null){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            StatusDataBox(Icons.toys, '쿨링 팬',0),
            StatusDataBox(Icons.lightbulb_outline, 'LED 조명',1),
            StatusDataBox(Icons.child_care, '영양제',2),
            StatusDataBox(Icons.flash_on,   '전원',3),
          ],
        );
    }
      else{
        print(snapshot.data.data);
        isbuttonTouched[0] = snapshot.data['fan'];
        isbuttonTouched[1] = snapshot.data['led'];
        isbuttonTouched[2] = snapshot.data['nutrition'];
        isbuttonTouched[3] = snapshot.data['power'];
         return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
        StatusDataBox(Icons.toys, '쿨링 팬',0),
        StatusDataBox(Icons.lightbulb_outline, 'LED 조명',1),
        StatusDataBox(Icons.child_care, '영양제',2),
        StatusDataBox(Icons.flash_on,   '전원',3),
        ],
        );
        }
        }
    ),
      ],
    );
  }

  Widget StatusDataBox(IconData icon,String description,int idx) {
    List<Color> colors = [Colors.white,style.mainBlue];
    return GestureDetector(
      onTap: (){
        setState(() {
          isbuttonTouched[idx] = !isbuttonTouched[idx];
          onOffUpdate(idx,isbuttonTouched[idx]);
        });
      },
      child: Container(
          width: 90,
          //margin: EdgeInsets.only(top:7.5),
          padding: EdgeInsets.only(top: 18,bottom: 18,),
          decoration: BoxDecoration(
            color: isbuttonTouched[idx]?colors[1]:colors[0],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Icon(icon,color:isbuttonTouched[idx]?colors[0]:colors[1],size: 40,),
              SizedBox(height: 5,),
              Text(description,style: TextStyle(color: isbuttonTouched[idx]?colors[0]:colors[1],fontSize: 10),),
            ],
          )
      ),
    );
  }
}


