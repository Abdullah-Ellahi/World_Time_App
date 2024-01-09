import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void setupWorldTime() async {
    ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "An error occurred during data retrieval!",
        onConfirmBtnTap: (){
          setupWorldTime();
        },
      );
      // Use setState to trigger a rebuild
    } else {
      WorldTime instance = WorldTime(location: 'Karachi', flagURL: 'pakistan.png', urlEndPoint: 'Asia/Karachi');
      await instance.getTime();

      print(instance);
      Navigator.pushReplacementNamed(context,'/home',arguments: {
        'location': instance.location,
        'flagURL': instance.flagURL,
        'time': instance.time,
        'hours': instance.hours,
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitPouringHourGlassRefined(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}
