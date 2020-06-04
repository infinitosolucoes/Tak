import 'package:flutter/material.dart';
import 'package:tak/Theme/theme.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background_color,
        elevation: 0,
        iconTheme: IconThemeData(
          color: primary_color
        ),
      ),
      backgroundColor: background_color,
      body: Center(
        child: Text('Ainda em desenvolvimento! :(', style: TextStyle(color: primary_color, fontSize: 25))
      ),
    );
  }
}