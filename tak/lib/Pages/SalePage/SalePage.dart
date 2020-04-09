import 'package:flutter/material.dart';
import 'package:tak/Objects/SaleItem.dart';
import 'package:tak/Theme/theme.dart';

class SalePage extends StatefulWidget {
  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<SaleItem> l = [];
  double total = 0;
  int methodPayment = 1;
  
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
                        onPressed: showMethodPayment,
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

  showMethodPayment(){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return Container(
	        padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile(
                title: const Text('Dinheiro', style: title_item,),
                groupValue: this.methodPayment,
                value: 1,
                onChanged: (int value){
                  setState((){
                    this.methodPayment = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Cartão de Débito', style: title_item,),
                groupValue: this.methodPayment,
                value: 2,
                onChanged: (int value){
                  setState((){
                    this.methodPayment = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Cartão de Crédito', style: title_item,),
                groupValue: this.methodPayment,
                value: 3,
                onChanged: (int value){
                  setState((){
                    this.methodPayment = value;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        color: success_color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text('Finalizar', style: button_text),
                        onPressed: (){ print(this.methodPayment);},
                      ),
                    )
                  )
                ],
              )
              
            ],
          )
        );
      }
    );
  }
}
