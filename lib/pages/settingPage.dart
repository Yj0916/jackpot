import 'dart:ui';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/style.dart' as style;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:jackpot/service/data.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {
  double waterLevel ;
  double fanLevel ;
  double ledLevel ;
  bool  unload = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: settingRetrieve() ,
      builder:(BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData == false){
          print('now loading!');
          return Center(child: CircularProgressIndicator());
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
          if(unload == false){
            waterLevel =  snapshot.data['WaterCycle'].toDouble();
            fanLevel = snapshot.data['FanLevel'].toDouble();
            ledLevel = snapshot.data['LedLevel'].toDouble();
            unload = true;
          }
          return Container(
            padding: EdgeInsets.only(left: 20,right: 5),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('images/wave.png',width: 30.0,
                          height: 35.0,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 10,),
                        Text('물 주기',style: style.iconText),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 85,
                      child:SfSliderTheme(
                        data: SfSliderThemeData(
                            activeTrackHeight: 15,
                            inactiveTrackHeight: 15,
                            thumbRadius: 13,
                            thumbStrokeWidth: 4,
                            thumbStrokeColor: Colors.white
                        ),
                        child:SfSlider(
                          min: 1.0,
                          numberFormat: NumberFormat('#D'),
                          max: 7.0,
                          interval: 1,
                          value: waterLevel,
                          showLabels: true,
                          showTooltip: true,
                          activeColor: style.buttonColor,
                          inactiveColor: style.inactiverColor,
                          onChanged: (dynamic value){
                            setState(() {
                              waterLevel = value;
                            });
                          },
                          stepSize: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('images/fan.png',width: 40.0,
                          height: 40.0,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 10,),
                        Text('쿨링팬',style: style.iconText),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 90,
                      child:SfSliderTheme(
                        data: SfSliderThemeData(
                            activeTrackHeight: 15,
                            inactiveTrackHeight: 15,
                            thumbRadius: 13,
                            thumbStrokeWidth: 4,
                            thumbStrokeColor: Colors.white
                        ),
                        child:SfSlider(
                          min: 0.0,
                          max: 10.0,
                          interval: 1,
                          value: fanLevel,
                          showLabels: true,
                          showTooltip: true,
                          activeColor: style.buttonColor,
                          inactiveColor: style.inactiverColor,
                          onChanged: (dynamic value){
                            setState(() {
                              fanLevel = value;
                            });
                          },
                          stepSize: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset('images/light.png',width: 30.0,
                          height: 35.0,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 10,),
                        Text('LED 밝기',style: style.iconText),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 85,
                      child:SfSliderTheme(
                        data: SfSliderThemeData(
                            activeTrackHeight: 15,
                            inactiveTrackHeight: 15,
                            thumbRadius: 13,
                            thumbStrokeWidth: 4,
                            thumbStrokeColor: Colors.white
                        ),
                        child:SfSlider(
                          min: 0.0,
                          max: 5.0,
                          interval: 1,
                          value: ledLevel,
                          showLabels: true,
                          showTooltip: true,
                          activeColor: style.buttonColor,
                          inactiveColor: style.inactiverColor,
                          onChanged: (dynamic value){
                            setState(() {
                              ledLevel = value;
                            });
                          },
                          stepSize: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap:(){
                    settingSave(waterLevel,fanLevel,ledLevel);
                    Alert(context: context, title: "수정완료", desc: "식물 정보가 수정 완료되었습니다.",buttons: [        DialogButton(
                      child: Text(
                        "확인",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: style.buttonColor,
                    )]).show();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top:15,bottom:15),
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: style.buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Text('설정완료',style: style.settingButtonTextStyle,textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
