import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
  void dispose(){
    this._controller.close;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapeshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text('Relatórios', style: app_bar),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: background_color, size: 20), 
                    onPressed: this._controller.decrement,
                  ),
                  Text(this._controller.phrase, style: app_bar),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: background_color, size: 20), 
                    onPressed: this._controller.increment,
                  ),
                  //SizedBox(width: 10,),
                ],
              )
            ),
          ),
          backgroundColor: background_color,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total de vendas:', style: title_item,),
                Text(this._controller.len.toString(), style: results,),
                
                SizedBox(height: 10,),

                Text('Faturamento Total:', style: title_item,),
                Text('R\$ ' + this._controller.amount.toStringAsFixed(2).replaceAll('.', ','), style: results),
                
                SizedBox(height: 50,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: success_color,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Dinheiro',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary_color,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Cartão de Débito',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                   
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: danger_color,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Cartão de Crédito',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: PieChart(
                        PieChartData(
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 2,
                          sections: this._controller.methodSegments(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}