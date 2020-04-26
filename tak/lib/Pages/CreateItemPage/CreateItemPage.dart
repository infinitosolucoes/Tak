import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Controllers/CreateItemPageController/CreateItemPageController.dart';
import 'package:tak/Functions/Validators.dart' as Validators;
import 'package:tak/Theme/theme.dart';

class CreateItemPage extends StatefulWidget {
  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final CreateItemPageController _controller = CreateItemPageController();

  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text('Novo Item', style: app_bar),
            actions: <Widget>[
              IconButton(
                icon: Icon(MdiIcons.contentSave, color: background_color, size: 30,),
                onPressed: (){
                  bool flag = this._controller.submit();
                  if(flag){
                    Navigator.pop(context, this._controller.newItem);
                  }
                }
              ),
              SizedBox(width: (width * 0.04),)
            ],
          ),
          backgroundColor: background_color,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: this._controller.formKey,
              autovalidate: this._controller.autoValidate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 
                 
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.all(Radius.circular(20.0)) 
                    ),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: this._controller.image,
                      fit: BoxFit.cover,
                      width: width,
                      height: 150.0,
                      child: InkWell(
                        onTap: this._controller.setImage,
                      ),
                    ),
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    validator: Validators.nameValidator,
                    onSaved: (String value){
                      this._controller.name = value;
                    },
                  ),
                
                
              
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Código de Barras',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: Validators.ean13Validator,
                    onSaved: (String value){
                      this._controller.id = value;
                    },
                  ),
                         

                  
                  

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Preço',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: Validators.priceValidator,
                    onSaved: (String value){
                      value = value.replaceAll(',', '.');
                      double price = double.parse(value);
                      this._controller.price = price;
                    },
                  ),
                ],
              )
            ),
          ),
        );
      },
    );
  }
}