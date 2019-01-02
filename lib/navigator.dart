import 'package:flutter/widgets.dart';

class FlutterNavigator {
  final push;
  final pop;
  final navigator = Navigator;
  FlutterNavigator({this.push, this.pop});
}

class FlutterNavigationTypes {
  static const String IOS = "MATERIAL";
  static const String MATERIAL = "MATERIAL";
}
