import 'dart:ui';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/style.dart' as style;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double waterLevel = 1;
  double drugLevel = 1;
  double fanLevel = 0;
  double ledLevel = 0;

  @override
  Widget build(BuildContext context) {
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
                  Image.asset('images/drug.png',width: 30.0,
                    height: 35.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 10,),
                  Text('영양제\n주기',style: style.iconText,textAlign: TextAlign.center,),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
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
                    value: drugLevel,
                    showLabels: true,
                    showTooltip: true,
                    activeColor: style.buttonColor,
                    inactiveColor: style.inactiverColor,
                    onChanged: (dynamic value){
                      setState(() {
                        drugLevel = value;
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
            onTap: null,
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
}
