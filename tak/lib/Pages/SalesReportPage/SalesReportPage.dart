import 'package:flutter/material.dart';
import 'package:tak/Controllers/SalesReportPageController/SalesReportPageController.dart';
import 'package:tak/Theme/theme.dart';

class SalesReportPage extends StatefulWidget {
  @override
  _SalesReportPageState createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {

  final SalesReportPageController _controller = SalesReportPageController();

  @override
  void initState(){
    this._controller.getListByDate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapeshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text('Relatórios', style: app_bar),
          ),
          backgroundColor: background_color,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text('Total de vendas:'),
                Text(this._controller.len.toString()),

                Text('Faturamento Total:'),
                Text(this._controller.amount.toStringAsFixed(2))
              ],
            ),
          ),
        );
      },
    );
  }
}