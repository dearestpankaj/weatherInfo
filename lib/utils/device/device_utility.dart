
import 'package:flutter/cupertino.dart';

class DeviceUtility {
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context!).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Orientation getDeviceOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }
}