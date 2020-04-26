import 'package:flutter/material.dart';
import 'package:tak/Functions/Router.dart' as Router;

void main() => runApp(Tak());

class Tak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tak',
      onGenerateRoute: Router.generateRoute,
      initialRoute: '/',
    );
  }
}

