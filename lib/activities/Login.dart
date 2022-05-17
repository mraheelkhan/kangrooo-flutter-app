import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kangrooo/activities/EmptyPage.dart';
import 'package:kangrooo/services/StayTimer.dart';
import 'package:kangrooo/services/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  late String deviceName;
  Uuid uuid = const Uuid();
  late String sessionUuid;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pinCodeController = TextEditingController();
  Utils utils = Utils();
  late StayTimer stayTimer;
  @override
  void initState() {
    print("started ===========================");
    WidgetsBinding.instance.addObserver(this);
    init();
    super.initState();
  }
  void init(){
    getDeviceName();
    sessionUuid = uuid.v4();
    stayTimer = StayTimer(sessionUuid);
  }
  void getDeviceName() async{
    deviceName = await utils.getDeviceName();
    stayTimer.autoTime(deviceName, 'Login');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("values ========== " + AppLifecycleState.values.toString());
    if (state == AppLifecycleState.paused) {
      print("paused ===========================");
    }
    if (state == AppLifecycleState.resumed) {
      print("resumed ===========================");
      init();
    }
    if (state == AppLifecycleState.inactive) {
      print("inactive ============================== ");
    }
    if (state == AppLifecycleState.detached) {
      print("detached ============================== ");
    }
  }

  Future<void> submit() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    var pincode = await stayTimer.verifyPinCode(pinCodeController.text);

    if(pincode){

      stayTimer.cancelTimer();
      Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => new EmptyPage(sessionUuid)),
          );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong pin code'),
          )
      );
    }

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print('dispose====================================');
    super.dispose();
  }

  late AppLifecycleState _notification;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pin Code"),
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                    keyboardType: TextInputType.number,
                    controller: pinCodeController,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    maxLength: 4,
                    decoration: const InputDecoration(
                        labelText: 'Pin Code',
                        fillColor: Colors.white,
                        filled: true),
                    validator: (String? value) {
                      // Validation condition
                      if (value!.isEmpty) {
                        return 'Please enter pin code';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () => submit(),
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 36)),
                  ),
                ],
              )),
        ));
  }
}
