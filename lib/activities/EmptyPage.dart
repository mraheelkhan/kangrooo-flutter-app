import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kangrooo/services/StayTimer.dart';
import 'package:kangrooo/services/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmptyPage extends StatefulWidget {
  final String sessionUid;
  EmptyPage(this.sessionUid);

  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {

  final prefs = SharedPreferences.getInstance();
  late String sessionUuid;
  late String deviceName;
  Utils utils = Utils();
  late StayTimer stayTimer;

  @override
  void initState() {
    super.initState();
    getDeviceName();
    sessionUuid = widget.sessionUid;
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => SystemNavigator.pop(),
            //return true when click on "Yes"
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }



  void init(){
    stayTimer = StayTimer(sessionUuid);
    stayTimer.autoTime(deviceName, 'EmptyPage');

  }
  void getDeviceName() async{
    deviceName = await utils.getDeviceName();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: showExitPopup, //call function on back button press
        child: Scaffold(
        appBar: AppBar(
          title: Text('Empty Page'),
        ),
        body: Center(
          child: Text('',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        )));
  }
}
