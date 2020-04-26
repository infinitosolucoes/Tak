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
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._controller.output,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total de vendas:', style: title_item,),
                Text(this._controller.len.toString(), style: results,),

                Text('Faturamento Total:', style: title_item,),
                Text('R\$ ' + this._controller.amount.toStringAsFixed(2).replaceAll('.', ','), style: results),
                
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
                      width: 5,
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
                
                
                
                // Container(
                //   child: AnimatedCircularChart(
                //     key: this._controller.chartKey,
                //     size: Size((height*0.5), (width*0.8)), 
                //     chartType: CircularChartType.Pie,
                //     holeLabel: 'Metodos',
                //     initialChartData: this._controller.methodSegments(),
                //   )
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}