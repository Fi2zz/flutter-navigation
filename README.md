# flutter-navigation

> Life is short, use Flutter Navigation

a flutter navigation solution

> currently support cupertino app

First, add `flutter_navigation` as a dependency in your pubspec.yaml file.

## Example

```dart
    import "package:flutter_navigation/navigation.dart";
    import 'some_widget_1.dart'
    import 'some_widget_2.dart'

    final screens ={
           "SomeWidget1":(params,navigation)=>SomeWidget(params:params,navigation:navigation),
           "SomeWidget2":(params,navigation)=>SomeWidget(params:params,navigation:navigation),
    }
    final navigationOptions ={
              "SomeWidget1":NavigationOptions(title:Text('Widget Title')),
              "SomeWidget2":NavigationOptions(title:Text('Widget Title')),
    }




void main(){

    return runApp(FlutterNavigation(
            screens:screens,
            navigationOptions:navigationOptions,
            onUnknownRoute:Route (FlutterNavigator navigation){
                return SomeCupertinoPageRoute();
            },
            navigationType: FlutterNavigationTypes.IOS,
            initialRoute:"Home",
            onPush: (params) {
                print("onPush ${params}");
            },
            onPop: (params) {
                print("onPop ${params}");
            },
    ))
}
// some_widget_1.dart
import 'package:flutter/cupertino.dart';

class SomeWidget extends StatefulWidget {
  SomeWidget({this.params, this.navigation});
  final Map params;
  final navigation;
  @override
  State<StatefulWidget> createState() => SomeWidgetWithState();
}
class SomeWidgetWithState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      CupertinoButton(
        child: Text('Go to profile'),
        onPressed: () {
          widget.navigation.push(context, "SomeWidget2", {"hello": Null});
        },
      )
    ]);
  }
}
```
