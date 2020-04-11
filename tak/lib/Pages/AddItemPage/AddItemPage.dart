import 'package:flutter/material.dart';
import 'package:tak/Theme/theme.dart';
import 'package:tak/Objects/Item.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        centerTitle: true,
        title: Text('Adicionar Item', style: app_bar),
      ),

       backgroundColor: background_color,
      
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index){
          Item item = items[index];
          return ListTile(
            title: Text(item.name, style: title_item),
            trailing: Text('R\$ ' +  item.price.toStringAsFixed(2).replaceAll('.', ','), style: subtotal_text),
            onTap: showAmountForm,
          );
        }, 
        separatorBuilder: (context, index){
          return Divider(
            height: 1,
            color: decoration_color,
          );
        },
        
      ),
    );
  }

  showAmountForm(){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, setState){
            return Container(
              child: Form(
                key: this._formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Informe a quantidade'
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: RaisedButton(
                                color: primary_color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text('Adicionar', style: button_text),
                                onPressed: (){},
                              ),
                            )
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}