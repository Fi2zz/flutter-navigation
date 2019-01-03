import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



createCupertinoNavigationBar(NavigationOptions navigationOptions) {
  return CupertinoNavigationBar(
    middle: navigationOptions.title,
    leading: navigationOptions.leading is Widget
        ? navigationOptions.leading
        : navigationOptions.leading is String
            ? Text(navigationOptions.leading)
            : null,
    trailing: navigationOptions.traling,
    padding: navigationOptions.padding,
    backgroundColor: navigationOptions.backgroundColor == null
        ? Color(0xCCF8F8F8)
        : navigationOptions.backgroundColor,
    transitionBetweenRoutes: navigationOptions.transitionBetweenRoutes,
    border: navigationOptions.border,
    automaticallyImplyLeading: navigationOptions.automaticallyImplyLeading,
    automaticallyImplyMiddle: navigationOptions.automaticallyImplyMiddle,
    previousPageTitle: navigationOptions.previousPageTitle,
  );
}

createMaterialNavigationBar(NavigationOptions navigationOptions) {
  return AppBar(
    title: navigationOptions.title,
  );
}

class NavigationOptions<CupertinoNavigationBar, AppBar> {
  NavigationOptions({
    this.title,
    this.leading,
    this.traling,
    this.actions,
    this.isCupertino,
    this.previousPageTitle,
    this.backgroundColor,
    this.actionsForegroundColor,
    this.iconTheme,
    this.textTheme,
    this.padding,
    this.centerTitle,
    this.titleSpacing,
    this.bottomOpacity,
  });
  String previousPageTitle;
  bool isCupertino = true;
  var leading;
  Widget title;
  Widget traling;
  List actions;
  Widget flexibleSpace;
  Color backgroundColor;
  Color actionsForegroundColor;
  bool automaticallyImplyLeading = true;
  bool automaticallyImplyMiddle = true;
  double elevation = 4.0;
  Brightness brightness;
  IconData iconTheme;
  TextTheme textTheme;
  bool primary = true;
  bool centerTitle;
  double titleSpacing = NavigationToolbar.kMiddleSpacing;
  double toolbarOpacity = 1.0;
  double bottomOpacity = 1.0;
  EdgeInsetsDirectional padding;
  Border border;
  bool transitionBetweenRoutes = true;
  PreferredSizeWidget bottom;
  Object heroTag;
}
