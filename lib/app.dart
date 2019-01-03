
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_navigation/unknown_route.dart';
import 'package:flutter_navigation/navigator.dart';
import 'package:flutter_navigation/navigation_bar.dart';
import 'package:flutter_navigation/page_scaffold.dart';
import 'package:flutter_navigation/constants.dart';





typedef Widget Screen(Map<String, dynamic> params, dynamic navigation);

class NavigationWithParams {
  final settings;
  final params;
  NavigationWithParams({this.settings, this.params});
}



class FlutterNavigation extends StatelessWidget  {

  FlutterNavigation({this.screens,
        this.onUnknownRoute,
        this.onPush,
        this.onPop,
        this.navigationOptions,
        this.navigationType = FlutterNavigationTypes.IOS,
        this.initialRoute})
  {
    this.navigation =FlutterNavigator(
        routeBuilder: this.routeBuilder,
               onPop: this.onPop,
              onPush: this.onPush);

  }


  Route routeBuilder(context,name,[params]){
    Widget page = this.pageBuilder(name, params);
    RouteSettings settings = RouteSettings(name: name, isInitialRoute: false);
   return  CupertinoPageRoute(builder: (BuildContext context) => page, settings: settings);
  }
  NavigationOptions getNavigationOptions(name) {
    try {
      return this.navigationOptions[name];
    } catch (error) {
      return null;
    }
  }
  FlutterNavigator navigation;
  final String navigationType;
  final Map screens;
  final Function onUnknownRoute;
  final Function onPush;
  final Function onPop;
  final navigationOptions;
  final String initialRoute;




  Widget pageBuilder(String name,[params]){
    final currentScreen = this.screens[name];
    final navigationOptions = this.getNavigationOptions(name);
    Widget screen;
    if (currentScreen != null) {
      screen = currentScreen(params, this.navigation);
    } else {
      //404 page
      screen =  this.onUnknownRoute is Function ? this.onUnknownRoute(this.navigation)   : FlutterUnkownRoute(this.navigation);
    }

    return Page(
        child: screen,
        navigationOptions: navigationOptions,
        navigationType: this.navigationType);

  }
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        color: Color.fromARGB(255, 255, 255, 255),
        initialRoute: this.initialRoute == null ? this.initialRoute : '/',
        home:  this.pageBuilder('Home'),
    );

  }
}


