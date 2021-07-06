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