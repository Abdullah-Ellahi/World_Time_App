import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String? time;
  String flagURL;
  String urlEndPoint;
  int hours;

  WorldTime({
    required this.location,
    required this.flagURL,
    required this.urlEndPoint,
  }) : hours = 0; // Initialize isDayTime to a default value

  Future<void> getTime() async {
    try{
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$urlEndPoint'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(now);
      hours = now.hour;
      // hours = (now.hour > 6 && now.hour < 19) ? true : false;
    }
    catch(e){
      print('caught error: $e');
      time = '00:00';
    }
  }
}
