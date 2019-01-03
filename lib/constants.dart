

class FlutterNavigationTypes {
  static const String IOS = "MATERIAL";
  static const String MATERIAL = "MATERIAL";
}


class FlutterInitRouteName{
  static const String HOME="HOME";
  static const String INDEX="INDEX";
}
isHomePage(String routeName){
  routeName =routeName.toUpperCase();
  return routeName ==FlutterInitRouteName.HOME || routeName ==FlutterInitRouteName.INDEX || routeName == '/';

}