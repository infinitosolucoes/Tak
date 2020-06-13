import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tak/Functions/Router.dart' as Router;

void main() {
    WidgetsFlutterBinding.ensureInitialized();   
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]).then((_){
    runApp(Tak());
   });
 }

class Tak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tak',
      onGenerateRoute: Router.generateRoute,
      initialRoute: '/login',
    );
  }
}

