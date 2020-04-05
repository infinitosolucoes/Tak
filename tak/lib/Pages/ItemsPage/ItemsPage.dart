import 'package:flutter/material.dart';
import 'package:tak/Theme/theme.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();

}

class _ItemsPageState extends State<ItemsPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Itens', style: app_bar),
      ),
      backgroundColor: background_color,
      body: ListView(children: <Widget>[],),
    );
  }

}