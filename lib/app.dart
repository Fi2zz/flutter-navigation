import 'dart:async';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_navigation/unknown_route.dart';
import 'package:flutter_navigation/navigator.dart';
import 'package:flutter_navigation/navigation_bar.dart';

typedef Widget Screen(Map<String, dynamic> params, dynamic navigation);

class NavigationWithParams {
  final settings;
  final params;

  NavigationWithParams({this.settings, this.params});
}

void callHookDelay(hook, [route, page, settings]) {
  if (hook is Function) {
    Timer.run(() => hook(route, page, settings));
  }
}

void resetDelay(callback) {
  new Timer(Duration(microseconds: 20), callback);
}

class FlutterNavigation extends StatelessWidget {
  Route currentRoute;
  Widget currentPage;
  String navigationType;
  RouteSettings currentRouteSettings;

  FlutterNavigation(
      {this.screens,
      this.onUnknownRoute,
      this.onPush,
      this.onPop,
      this.navigationOptions,
      this.navigationType = FlutterNavigationTypes.IOS,
      this.initialRoute}) {
    this.navigation = FlutterNavigator(pop: (context, [params]) {
      final localParams = NavigationWithParams(
          params: params, settings: this.currentRouteSettings);
      Navigator.pop(context, localParams);
      this.callHook(this.onPop, params, true);
    }, push: (context, name, [params]) {
      Widget page = this.pageCreator(name, params);
      RouteSettings settings = RouteSettings(name: name, isInitialRoute: false);
      CupertinoPageRoute route = CupertinoPageRoute(
          builder: (BuildContext context) => page, settings: settings);
      this.currentRoute = route;
      this.currentPage = page;
      this.currentRouteSettings = settings;
      Navigator.push(context, this.currentRoute);
      this.callHook(this.onPush, params, false);
    });
  }

  void callHook(hook, params, reset) {
    final localParams = NavigationWithParams(
        params: params, settings: this.currentRouteSettings);
    callHookDelay(hook, this.currentRoute, this.currentPage, localParams);
    if (reset) {
      resetDelay(() {
        this.currentRoute = null;
        this.currentPage = null;
        this.currentRouteSettings = null;
      });
    }
  }

  final screens;
  final Function onUnknownRoute;
  final Function onPush;
  final Function onPop;
  final navigationOptions;
  final String initialRoute;

  NavigationOptions getNavigationOptions(name) {
    try {
      return this.navigationOptions[name];
    } catch (error) {
      // return {};
      return null;
    }
  }

  FlutterNavigator navigation;
  Widget pageCreator(name, params) {
    final currentScreen = this.screens[name];
    final navigationOptions = this.getNavigationOptions(name);
    Widget screen;
    if (currentScreen != null) {
      screen = currentScreen(params, this.navigation);
    } else {
      //404 page
      screen = this.onUnknownRoute == null
          ? FlutterUnkownRoute(this.navigation)
          : this.onUnknownRoute is Function
              ? this.onUnknownRoute(this.navigation)
              : FlutterUnkownRoute(this.navigation);
    }

    return _Page(
        child: screen,
        navigationOptions: navigationOptions,
        navigationType: this.navigationType);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        color: Color.fromARGB(255, 255, 255, 255),
        initialRoute: this.initialRoute == null ? this.initialRoute : '/',
        home: this.pageCreator('Home', {}));
  }
}

//Page Scaffold;
class _Page extends StatelessWidget {
  _Page({Key key, this.navigationOptions, this.navigationType, this.child})
      : super(key: key);
  final navigationOptions;

  final navigationType;

  Widget getNavigationBar() {
    if (this.navigationType == FlutterNavigationTypes.IOS) {
      return createCupertinoNavigationBar(this.navigationOptions);
    } else if (navigationType == FlutterNavigationTypes.MATERIAL) {
      return createMaterialNavigationBar(this.navigationOptions);
    } else {
      return null;
    }
  }

  final child;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      navigationBar: this.getNavigationBar(),
      child: new Container(
        padding: EdgeInsets.only(top: 64),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: this.child,
      ),
    );
  }
}
