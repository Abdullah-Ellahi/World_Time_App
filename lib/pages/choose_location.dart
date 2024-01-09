import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(urlEndPoint: 'Asia/Gaza', location: 'Gaza', flagURL: 'gaza.png'),
    WorldTime(urlEndPoint: 'Europe/London', location: 'London', flagURL: 'uk.png'),
    WorldTime(urlEndPoint: 'Asia/Karachi', location: 'Karachi', flagURL: 'pakistan.png'),
    WorldTime(urlEndPoint: 'Asia/Hong_Kong', location: 'Hong_Kong', flagURL: 'hongkong.png'),
    WorldTime(urlEndPoint: 'Asia/Amman', location: 'Amman', flagURL: 'amman.png'),
    WorldTime(urlEndPoint: 'Asia/Baghdad', location: 'Baghdad', flagURL: 'baghdad.png'),
    WorldTime(urlEndPoint: 'Asia/Riyadh', location: 'Riyadh', flagURL: 'riyadh.png'),
    WorldTime(urlEndPoint: 'Asia/Tokyo', location: 'Tokyo', flagURL: 'tokyo.png'),
    WorldTime(urlEndPoint: 'Europe/Berlin', location: 'Athens', flagURL: 'greece.png'),
    WorldTime(urlEndPoint: 'Africa/Cairo', location: 'Cairo', flagURL: 'egypt.png'),
    WorldTime(urlEndPoint: 'Asia/Tashkent', location: 'Tashkent', flagURL: 'uzbekistan.png'),

    WorldTime(urlEndPoint: 'America/Chicago', location: 'Chicago', flagURL: 'usa.png'),
    WorldTime(urlEndPoint: 'Africa/Abidjan', location: 'Abidjan', flagURL: 'kenya.png'),
    WorldTime(urlEndPoint: 'Africa/Casablanca', location: 'Casablanca', flagURL: 'kenya.png'),
    WorldTime(urlEndPoint: 'Africa/Johannesburg', location: 'Johannesburg', flagURL: 'johannesburg.png'),
    WorldTime(urlEndPoint: 'America/Phoenix', location: 'Phoenix', flagURL: 'usa.png'),
    WorldTime(urlEndPoint: 'Africa/Casablanca', location: 'Casablanca', flagURL: 'kenya.png'),
    WorldTime(urlEndPoint: 'Africa/Algiers', location: 'Algiers', flagURL: 'algeria.png'),
    WorldTime(urlEndPoint: 'Africa/Nairobi', location: 'Nairobi', flagURL: 'kenya.png'),

    WorldTime(urlEndPoint: 'America/New_York', location: 'New York', flagURL: 'usa.png'),
    WorldTime(urlEndPoint: 'Asia/Seoul', location: 'Seoul', flagURL: 'south_korea.png'),
    WorldTime(urlEndPoint: 'Asia/Jakarta', location: 'Jakarta', flagURL: 'indonesia.png'),
  ];

  void updateTime(int index) async {
    WorldTime instance = locations[index];

    try {
      await instance.getTime();

      if (mounted) {
        if (instance.time == '00:00') {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Unable to retrieve data!\nCheck your internet connection!",
          );
        } else {
          Navigator.pop(context, {
            'location': instance.location,
            'flagURL': instance.flagURL,
            'time': instance.time,
            'hours': instance.hours,
          });
        }
      }
    } catch (e) {
      // Handle exceptions that may occur during the asynchronous operation
      print('Error: $e');
      if (mounted) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "An error occurred during data retrieval!",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
            'Choose A Location',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                child: ListTile(
                  onTap: (){
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/flags/${locations[index].flagURL}'),
                  ),
                )
              ),
            );
          }
      ),
    );
  }
}
