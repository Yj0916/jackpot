import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jackpot/service/weather.dart';
import '../style.dart' as style;
import '../databox.dart';
import 'package:weather_icons/weather_icons.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Jackpot',
          style: style.titleStyle,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black26),
        centerTitle: true,
      ),
      body: Column(
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
                          iconReturn(snapshot.data.weatherConditionCode),
                          size: 45,
                          color: Colors.black,
                        ),
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
/*
                        Container(
                          padding: EdgeInsets.only(top:11,left: 10,right: 10,bottom: 11),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                List: [Color(0xffe2f7fe), Color(0xfff8faeb)]),
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
            },
          ),
          DataBox(Column(
            children: <Widget>[
              Text('JackPot 상태',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.wb_cloudy,color: style.mainBlue,),
                        SizedBox(width: 5,),
                        Text('미세먼지',style: TextStyle(fontSize: 12,color: style.greyText),),
                      ],
                    ),
                    NumberData(13,'㎍/m³')
                  ],),
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.hourglass_empty,color: style.mainBlue,),
                        SizedBox(width: 5,),
                        Text('온도',style: TextStyle(fontSize: 12,color: style.greyText),),
                      ],
                    ),
                    NumberData(26,'℃')
                  ],),
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.bubble_chart,color: style.mainBlue,),
                        SizedBox(width: 5,),
                        Text('습도',style: TextStyle(fontSize: 12,color: style.greyText),),
                      ],
                    ),
                    NumberData(81,'%'),
                  ],),
                ],
              ),
            ],
          ),7.5,7.5),
          DataBox(Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                  Text('수위')
                ],
              ),
              NumberData(33,'%'),
              SizedBox(height: 5,),
              Text('물탱크에 물이 얼마 남지 않았어요. 물을 충전해주세요.',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)
            ],
          ),7.5,7.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StatusDataBox(Icons.toys, '쿨링 팬'),
              StatusDataBox(Icons.lightbulb_outline, 'LED 조명'),
              StatusDataBox(Icons.child_care, '영양제'),
              StatusDataBox(Icons.flash_on,   '전원'),
            ],
          ),
        ],
      ),
      drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: style.mainBlue,
            unselectedItemColor: Colors.black26,
            onTap: null,
            currentIndex: 0,
            items: [
              new BottomNavigationBarItem(
                  icon: Icon(Icons.home,size: 30,),
                  title: Text('')
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.photo_camera,size: 30,),
                title: Text('')
              ),
              new BottomNavigationBarItem(
                  icon: Icon(Icons.add_box,size: 30,),
                  title: Text('')
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart,size: 30,),
                  title: Text('')
              ),
              new BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart,size: 30,),
                  title: Text('')
              )
            ])
    );
  }
}


