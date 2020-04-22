import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideLeftTransition extends CupertinoPageRoute {
  final Widget page;
  SlideLeftTransition({this.page})
      : super(builder: (BuildContext context) => page);
      
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Animation<Offset> custom = Tween<Offset>(begin: Offset(1.25,0), end: Offset(0,0)).animate(animation);
    return new SlideTransition(position: custom, child: this.page);
  }
}