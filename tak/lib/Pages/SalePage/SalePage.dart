import 'package:flutter/material.dart';
import 'package:tak/Theme/theme.dart';

class SalePage extends StatefulWidget {
  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Nova Venda', style: app_bar),
      ),
      backgroundColor: background_color,
      bottomNavigationBar: BottomAppBar(
        color: background_color,
        child: Container(
          padding: EdgeInsets.all((width*0.07)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Total: ', style: sale_title),
                  Text('R\$ 00,00', style: total_text)
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child:RaisedButton(
                        color: primary_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text('Adicionar', style: button_text),
                        onPressed: (){},
                      ),
                    )
                  ),
                  SizedBox(
                    width: (width * 0.04),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        color: success_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text('Continuar', style: button_text),
                        onPressed: (){},
                      ),
                    ),
                  )
                  
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: <Widget>[],),
    );
  }
}