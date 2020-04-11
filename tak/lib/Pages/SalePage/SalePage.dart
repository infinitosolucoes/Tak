import 'package:flutter/material.dart';
import 'package:tak/Objects/SaleItem.dart';
import 'package:tak/Objects/Item.dart';
import 'package:tak/Theme/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SalePage extends StatefulWidget {
  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
  List<SaleItem> _l = [
    new SaleItem(amount: 3, id: 0, item: items[2]),
    new SaleItem(amount: 3, id: 0, item: items[2]),
    new SaleItem(amount: 3, id: 0, item: items[2]),
    new SaleItem(amount: 3, id: 0, item: items[2]),
  ];
  double _total = 0;
  int _methodPayment = 1;

  double calculateTotal(List<SaleItem> list){
    double value = 0;
    for(int i = 0; i < list.length; i++){
      value = value + (list[i].amount * list[i].item.price);
    }
    return value;
  }

  void initState(){
    super.initState();
    this._total = this.calculateTotal(this._l);
  }
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Nova Venda', style: app_bar),
      ),
      backgroundColor: background_color,
      
      body: ListView.separated(
        itemCount: this._l.length,
        itemBuilder: (context, index){
          SaleItem item = this._l[index];
          return ListTile(
            title: Text(item.item.name, style: title_item),
            subtitle: Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(item.amount.toString() + ' x R\$ '+ item.item.price.toString().replaceAll('.',','), style: subtitle_item ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('R\$ ' + (item.amount * item.item.price).toStringAsFixed(2).replaceAll('.', ','), style: subtotal_text),
                IconButton(
                  icon: Icon(MdiIcons.closeCircleOutline, size: (height*0.05), color: danger_color),
                  onPressed: (){
                    setState(() {
                      this._l.removeAt(index);
                      this._total = this.calculateTotal(this._l);
                    });
                  },
                )
              ],
            ),
          );
        }, 
        separatorBuilder: (context, index){
          return Divider(
            height: 1,
            color: decoration_color,
          );
        },
        
      ),

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
                  Text('R\$ '+ this._total.toStringAsFixed(2).replaceAll('.', ','), style: total_text)
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
                        onPressed: (){
                           Navigator.pushNamed(context, '/newSale/addItem');
                        },
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
    );
  }

  showMethodPayment(){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, setState){
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile(
                    title: const Text('Dinheiro', style: title_item,),
                    groupValue: this._methodPayment,
                    value: 1,
                    onChanged: (int value){
                      setState((){
                        this._methodPayment = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Cartão de Débito', style: title_item,),
                    groupValue: this._methodPayment,
                    value: 2,
                    onChanged: (int value){
                      setState((){
                        this._methodPayment = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('Cartão de Crédito', style: title_item,),
                    groupValue: this._methodPayment,
                    value: 3,
                    onChanged: (int value){
                      setState((){
                        this._methodPayment = value;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                    child: Row(
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
                              onPressed: (){ print(this._methodPayment);},
                            ),
                          )
                        )
                      ],
                    )
                  ),
                  
                  
                ],
              )
            );
          }
        );
      }
    );
  }
}
