import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:world_time/controller/dependency_injection.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

void main() {
  DependencyInjection.init();
  runApp(GetMaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
Widget loadingBuilder(BuildContext context) => Loading();

Widget homeBuilder(BuildContext context) => Home();

Widget chooseLocationBuilder(BuildContext context) => ChooseLocation();
