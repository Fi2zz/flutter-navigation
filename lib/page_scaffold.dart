
import 'package:flutter/cupertino.dart';
import 'package:flutter_navigation/navigation_bar.dart';
import 'package:flutter_navigation/constants.dart';



class Page extends StatelessWidget {
  Page({Key key, this.navigationOptions, this.navigationType, this.child})
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
      child: Container(
        padding: EdgeInsets.only(top: 64),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: this.child,
      ),
    );
  }
}
