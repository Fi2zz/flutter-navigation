import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_navigation/constants.dart';

void callDelay(Function hook,params) {
  if (hook is Function) {
    Timer.run(() => hook(params));
  }
}
void delay(Function callback) {
  new Timer(Duration(microseconds: 20), callback);
}
class FlutterNavigator {
 void push(context, name, [params]){

   if(FlutterNavigator.isInitRoute(name)){
     this.popUntil(context, '/');
     callDelay(this.onPop, params);
     return ;
   }
   Navigator.push(context, this.routeBuilder(context,name,params));
   callDelay(this.onPush,params);
 }
 void pop(context,[params]){
   if(! this.canPop(context)){
     return ;
   }
   Navigator.pop(context,params);
   callDelay(this.onPop,params);
 }

 var onPush;
 var onPop;
 bool canPop(context)=>Navigator.canPop(context);


 void pushNamed(context,name,[params])=>   this.push(context, name,params);
 void popUntil(context,name) =>Navigator.popUntil(context, ModalRoute.withName(name));
 void home(context)=>this.popUntil(context, '/');
 void replace(context,newRouteName,oldRouteName){
     final Route newRoute =this.routeBuilder(context, newRouteName);
     final Route oldRoute =this.routeBuilder(context, oldRouteName);
     Navigator.replace(context, oldRoute: oldRoute, newRoute: newRoute);
 }
 static bool isInitRoute(routeName)=>isHomePage(routeName);
 final Function routeBuilder;
 FlutterNavigator({this.routeBuilder,this.onPop,this.onPush});
}

