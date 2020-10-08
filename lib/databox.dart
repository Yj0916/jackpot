import 'package:flutter/material.dart';
import 'style.dart' as style;

Widget DataBox(Column data,double top,double bottom) {
  return Container(
    padding: EdgeInsets.only(top: 22,left: 18,right: 18,bottom: 22,),
    //margin: EdgeInsets.only(left: 15,right: 15,top: top,bottom: bottom),
    margin: EdgeInsets.only(left: 15,right: 15),
    decoration: BoxDecoration(
      color: Colors.white,
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
    child: data,
  );
}


Widget StatusDataBox(IconData icon,String description) {

  return GestureDetector(
    child: Container(
        width: 90,
        //margin: EdgeInsets.only(top:7.5),
        padding: EdgeInsets.only(top: 18,bottom: 18,),
        decoration: BoxDecoration(
          color: Colors.white,
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
            Icon(icon,color: style.mainBlue,size: 40,),
            SizedBox(height: 5,),
            Text(description,style: TextStyle(color: style.mainBlue,fontSize: 10),),
          ],
        )
    ),
    onTap:null,
  );
}

Widget NumberData(int number, String unit)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: <Widget>[
      Text(number.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
      Text(unit,style: TextStyle(fontSize: 20,))
    ],
  );
}
