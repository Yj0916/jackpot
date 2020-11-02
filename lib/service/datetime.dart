String DateString(){
  DateTime now = DateTime.now();
  String month = now.month.toString();
  String day = now.day.toString();
  int weekday = now.weekday;
  String weekString = null;

  switch(weekday){
    case 1:
      weekString = "월요일";
      break;
    case 2:
      weekString = "화요일";
      break;
    case 3:
      weekString = "수요일";
      break;
    case 4:
      weekString = "목요일";
      break;
    case 5:
      weekString = "금요일";
      break;
    case 6:
      weekString = "토요일";
      break;
    case 7:
      weekString = "일요일";
      break;
  }

  String returnString = "$month월 $day일 $weekString";
  return returnString;
}