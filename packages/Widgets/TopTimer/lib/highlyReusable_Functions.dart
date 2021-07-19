void customPrint (Object object1, {Object object2 = '-------------------------------------------------'}){
  print('\n');
  print('\n  ');
  print(object1);
  print(object2);
  print('\n');
  print('\n  ');
}

String durationToStringTime ({required Duration duration}){
  return '${duration.inHours}:${duration.inMinutes.remainder(60).toString().padLeft(2,'0') }:${duration.inSeconds.remainder(60).toString().padLeft(2,'0')}';
}
String durationToStringTimeDB ({required Duration duration}){
  return '${duration.inHours.toString().padLeft(2,'0') }-${duration.inMinutes.remainder(60).toString().padLeft(2,'0') }-${duration.inSeconds.remainder(60).toString().padLeft(2,'0')}';
}
Duration stringToDurationDB ({required String duration}){
  return Duration(hours: int.parse(duration.substring(0,2)), minutes: int.parse(duration.substring(3,5)), seconds: int.parse(duration.substring(6,8)));
}
String dateTimeIn_dd_mm_yyyy_formatNow(){
  return '${DateTime.now().toString().substring(8,10)}-${DateTime.now().toString().substring(5,7)}-${DateTime.now().toString().substring(0,4)}';
}