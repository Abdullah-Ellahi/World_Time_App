import 'package:get/get.dart';
import 'package:world_time/controller/network_controller.dart';

class DependencyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}