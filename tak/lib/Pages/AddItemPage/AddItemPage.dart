import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tak/Theme/theme.dart';
import 'package:tak/Objects/Item.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  int _amount;
  Item _itemSelected;

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
            onTap: (){
              showAmountForm();
              setState(() {
                this._itemSelected = item;
              });   
            },
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
      isScrollControlled: true,
      builder: (BuildContext context){
        return StatefulBuilder(
          builder: (BuildContext context, setState){
            return Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: this._formKey,
                autovalidate: this._autoValidate,
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
                        validator: (String val){
                          try{
                            int.parse(val);
                            return null;
                          }catch(e){
                            return 'Quantidade Inválida';
                          }
                        },
                        onSaved: (String val){
                          this._amount = int.parse(val);
                        },
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
                                onPressed: this._saveForm,
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
  void _saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      sleep(const Duration(milliseconds: 500));
      if((this._itemSelected != null) && (this._amount != null)){ print("\n Pode Criar"); }
      Navigator.pop(context);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}