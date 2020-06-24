import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Controllers/FormItemPage/FormItemPageController.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Functions/Validators/Validators.dart' as Validators;
import 'package:tak/Objects/Item.dart';
import 'package:tak/Theme/Theme.dart';

class FormItemPage extends StatefulWidget {

  final Item itemEdit;

  FormItemPage({
    @required this.itemEdit
  });

  @override
  _FormItemPageState createState() => _FormItemPageState();
}

class _FormItemPageState extends State<FormItemPage> {
  final FormItemPageController _controller = FormItemPageController();

  @override
  void initState(){
    this._controller.initialize(widget.itemEdit);
    super.initState();
  }
  @override
  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text(this._controller.appBarText, style: app_bar),
            actions: <Widget>[

              // Botão de Salvar o Item
              IconButton(
                icon: Icon(MdiIcons.contentSave, color: background_color, size: 30,),
                onPressed: () async {await this._controller.submit(context);}
              ),
              SizedBox(width: 10,)
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
                 
                 // Ícone do Item
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.all(Radius.circular(20.0)) 
                    ),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: this._controller.image,
                      fit: BoxFit.cover,
                      width: 150.0,
                      height: 150.0,
                      child: InkWell(
                        onTap: this._controller.setImage,
                      ),
                    ),
                  ),
                  
                  // Nome do item
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: phrases['name'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.name,
                    validator: (String value){
                      return Validators.textValidator(value,2);
                    },
                    onSaved: (String value){
                      this._controller.name = value;
                    },
                  ),
                
                
                  // Código de Barras do Item
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: phrases['barcode'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    maxLength: 13,
                    keyboardType: TextInputType.phone,
                    initialValue: this._controller.id,
                    validator: (String value){
                      return this._controller.ean13Result;
                    },
                    onChanged: (String value){this._controller.ean13Value = value;},
                    onSaved: (String value){
                      this._controller.id = value;
                    },
                  ),
                         
                  // Preço do Item
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: phrases['price'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    keyboardType: TextInputType.phone,
                    initialValue: this._controller.getPrice(),
                    validator: Validators.priceValidator,
                    onSaved: this._controller.savePrice,
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
