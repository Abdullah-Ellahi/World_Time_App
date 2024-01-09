import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    if(data['time'] == '00:00'){
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "Unable to retrieve data!\nCheck your internet connection!",
      );
    }
    print(data);

    int hours = data['hours'];
    String bgImage;
    bool isNight = false;
    if(hours >= 7 && hours <= 8) {
      bgImage = 'assets/times/sunrise.png';
    } else if(hours > 8 && hours <= 17){
      bgImage =  'assets/times/day.png';
    } else if(hours > 17 && hours <= 19){
      bgImage =  'assets/times/sunset.png';
    } else {
      isNight = true;
      bgImage =  'assets/times/night.png';
    }


    return Scaffold(
      body:  SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImage),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');

                        if(result != null) {
                          setState(() {
                            data = {
                              'time': result['time'],
                              'location': result['location'],
                              'hours': result['hours'],
                              'flagURL': result['flagURL'],
                            };
                          });
                        }

                        if (data['time'] == '00:00') {
                          Future.delayed(Duration.zero, () {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: "Unable to retrieve data!\nCheck your internet connection!",
                            );
                          });
                        }
                      },
                      icon: Icon(Icons.edit_location),
                      label: Text('Edit Location'
                      ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: isNight ? Colors.white : Colors.black,
                          fontSize: 28,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                      data['time'],
                    style: TextStyle(
                      color: isNight ? Colors.white : Colors.black,
                      fontSize: 60,
                    ),
                  )
                ],
              ),
            ),
          ),
      )
    );
  }
}
