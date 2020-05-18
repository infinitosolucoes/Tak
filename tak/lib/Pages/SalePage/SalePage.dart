import 'package:flutter/material.dart';
import 'package:tak/Controllers/SalePageControllers/MethodPaymentController.dart';
import 'package:tak/Controllers/SalePageControllers/SalePageController.dart';
import 'package:tak/Objects/SaleItem.dart';
import 'package:tak/Theme/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SalePage extends StatefulWidget {
  @override
  _SalePageState createState() => _SalePageState();
}

class _SalePageState extends State<SalePage> {
 
  final SalePageController _controller = SalePageController();
  final MethodPaymentController _methodController = MethodPaymentController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
            appBar: AppBar(
              backgroundColor: primary_color,
              centerTitle: true,
              title: Text('Nova Venda', style: app_bar),
            ),
            backgroundColor: background_color,

            body: ListView.separated(
              itemCount: this._controller.len(),
              separatorBuilder: (context, index) => divider,
              itemBuilder: (context, index){
                SaleItem item = this._controller.getSaleItem(index);
                return ListTile(
                  leading: Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.all(Radius.circular(10.0)) 
                    ),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: this._controller.getImageItem(item),
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                      
                    ),
                  ),
                  title: Text(item.item.name, style: title_item),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(item.amount.toString() + ' x R\$ '+ item.item.price.toString().replaceAll('.',','), style: subtitle_item ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('R\$ ' + (item.calculateTotal()).toStringAsFixed(2).replaceAll('.', ','), style: subtotal_text),
                      IconButton(
                        icon: Icon(MdiIcons.closeCircleOutline, size: (height*0.05), color: danger_color),
                        onPressed: (){this._controller.decrementTotal(index);},
                      )
                    ],
                  ),
                );
              }
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
                        Text('R\$ '+ this._controller.getTotal().toStringAsFixed(2).replaceAll('.', ','), style: total_text)
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
                              shape: shape,
                              child: Text('Adicionar', style: button_text),
                              onPressed: () async {
                                var newSaleItem =  await Navigator.pushNamed(context, '/newSale/addItem');
                                this._controller.incrementTotal(newSaleItem);
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
                              shape: shape,
                              child: Text('Continuar', style: button_text),
                              onPressed: this.showMethodPayment,
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
    );
  }
  

  showMethodPayment(){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return StreamBuilder(
          stream: this._methodController.output,
          builder: (context,snapshot){
            return Container(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile(
                    title: const Text('Dinheiro', style: title_item,),
                    groupValue: this._methodController.getMethod(),
                    value: 1,
                    onChanged: (int value){
                      this._methodController.setMethod(value);
                    },
                  ),
                  RadioListTile(
                    title: const Text('Cartão de Débito', style: title_item,),
                    groupValue: this._methodController.getMethod(),
                    value: 2,
                    onChanged: (int value){
                      this._methodController.setMethod(value);
                    },
                  ),
                  RadioListTile(
                    title: const Text('Cartão de Crédito', style: title_item,),
                    groupValue: this._methodController.getMethod(),
                    value: 3,
                    onChanged: (int value){
                      this._methodController.setMethod(value);
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
                              shape: shape,
                              child: Text('Finalizar', style: button_text),
                              onPressed: (){
                                this._controller.setMethod(this._methodController.getMethod());
                                if(this._controller.finalizeSale()){
                                  Navigator.pushNamed(context, '/newSale/invoice', arguments: this._controller.newSale);
                                  //Navigator.pushNamedAndRemoveUntil(context,'/', (Route<dynamic> route) => false);
                                }
                              },
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

  @override
  void dispose(){
    this._controller.close;
    this._methodController.close;
    super.dispose();
  }
}
