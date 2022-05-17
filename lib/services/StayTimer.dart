import 'dart:async';
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
class StayTimer {

  StayTimer(this.sessionId);

  FirebaseDatabase database = FirebaseDatabase.instance;
  final db = FirebaseDatabase.instance.ref();

  late String deviceName;
  late String sessionId;
  int stayTime = 0;
  DateTime currentDateTime = DateTime.now();
  late Timer _timer;
  void autoTime(String deviceName, String pageName){
    this.deviceName = deviceName;
    const fiveSeconds = Duration(seconds: 2);

    _timer = Timer.periodic(fiveSeconds, (Timer t) {
      var difference = currentDateTime.difference(DateTime.now());
      stayTime = -(difference.inSeconds);
      print(stayTime);

      // addStayTime(stayTime, pageName);
    });


  }

  void cancelTimer(){
    _timer.cancel();
  }
  void addStayTime(int stayTime, String pageName){
    database.ref().child('stats/$deviceName/$sessionId/$pageName')
        .set(
        {
          'session' : sessionId,
          'currentDateTime_SessionStartTime' : currentDateTime.toString(),
          'page': pageName,
          'stayTime': stayTime
        });
  }

  Future<bool> verifyPinCode(var pincode) async{
    final snapshot = await db.child("settings/code").get();

    // return snapshot.toString();
    if(snapshot.exists){
      if(pincode == snapshot.value){
        return true;
      }
      return false;
    }
    return false;
  }
}