
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Controllers/CompanyPage/CompanyController.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Functions/Validators/Validators.dart' as Validators;
import 'package:tak/Theme/Theme.dart';


class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>{
  
  final CompanyController _controller = CompanyController();
  
  

  @override
  void dispose() {
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
            title: Text('Perfil', style: app_bar),
            actions: <Widget>[
              IconButton(
                icon: Icon(this._controller.icon, color: background_color, size: 30,),
                onPressed: () async {await this._controller.buttonAction(context);},
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

                  // Foto de Perfil
                  Material(
                    shape: CircleBorder(
                      side: BorderSide(color: primary_color, width: 4)
                    ),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: Ink.image(
                      image: this._controller.image,
                      fit: BoxFit.cover,
                      width: 200.0,
                      height: 200.0,
                      child: InkWell(
                        onTap: (this._controller.editMode)? this._controller.setImage: null,
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Text(this._controller.email, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                  SizedBox(height: 8,),

                  // Campo de Nome Fantasia
                  TextFormField(
                    enabled: this._controller.editMode,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.account, size: 30, color: decoration_color),
                      labelText: phrases['fancyNameField'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.name,
                    onSaved: (String value){this._controller.name = value;},
                    validator: (String value){
                      return Validators.textValidator(value,2);
                    },
                  ),

                  // Campo CNPJ
                  TextFormField(
                    enabled: this._controller.editMode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.badgeAccountHorizontalOutline, size: 30, color: decoration_color),
                      labelText: phrases['cnpjField'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.cnpj,
                    maxLength: 14,
                    onSaved: (String value){this._controller.cnpj = value;},
                    onChanged: (String value){ this._controller.cnpjValue = value;},
                    validator: (String value){ return this._controller.cnpjResult;},  
                  ),

                  // Campo Número de Telefone
                  TextFormField(
                    enabled: this._controller.editMode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.phone, size: 30, color: decoration_color),
                      labelText: phrases['numberField'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.phoneNumber,
                    maxLength: 11,
                    onSaved: (String value){this._controller.phoneNumber = value;},
                    validator: Validators.phoneValidator,
                  ),


                  SizedBox(height: 20,),
                  Text(phrases['address'], style: title_item),

                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        // Campo de Rua
                        child: TextFormField(
                          enabled: this._controller.editMode,
                          decoration: InputDecoration(
                            labelText: phrases['locationField'],
                            errorStyle: TextStyle(color: danger_color),
                          ),
                          initialValue: this._controller.location,
                          onSaved: (String value){this._controller.location = value;},
                          validator: (String value){
                            return Validators.textValidator(value,4);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 1,
                        // Campo de número da casa
                        child: TextFormField(
                          enabled: this._controller.editMode,
                          decoration: InputDecoration(
                            labelText: phrases['houseNumberField'],
                            errorStyle: TextStyle(color: danger_color),
                          ),
                          initialValue: this._controller.houseNumber,
                          onSaved: (String value){this._controller.houseNumber = value;},
                          validator: (String value){
                            return Validators.textValidator(value,1);
                          },
                        ),
                      )
                    ],
                  ),

                  // Campo de Bairro
                  TextFormField(
                    enabled: this._controller.editMode,
                    decoration: InputDecoration(
                      labelText: phrases['districtNumberField'],
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.district,
                    onSaved: (String value){this._controller.district = value;},
                    validator: (String value){
                      return Validators.textValidator(value,2);
                    },
                  ),


                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 4,
                        // Campo de Município
                        child: TextFormField(
                          enabled: this._controller.editMode,
                          decoration: InputDecoration(
                            labelText: phrases['cityField'],
                            errorStyle: TextStyle(color: danger_color),
                          ),
                          initialValue: this._controller.city,
                          onSaved: (String value){this._controller.city = value;},
                          validator: (String value){
                            return Validators.textValidator(value,2);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        flex: 1,
                        // Campo de Estado Federativo do Brasil 
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint:Text(this._controller.fu),
                            
                            items: this._controller.options,
                            value: this._controller.fu,
                            onChanged: (value) {
                              this._controller.fu = value;
                            },
                          ),
                        )
                      ),
                    ],
                  ),
            
                ],
              ),
            )
          ),
          bottomNavigationBar: Visibility(
            visible: !(this._controller.editMode),
            child: BottomAppBar(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        // Botão para deletar o usuário
                        child: RaisedButton(
                          shape: shape,
                          child: Text(phrases['deleteButton'], style: button_text),
                          color: danger_color,
                          onPressed: () async {await this._controller.deleteCompany(context);},
                        )
                      )
                    ),
                     SizedBox(
                      width: (width * 0.04),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        // Botão para fazer o LogOut 
                        child: RaisedButton(
                          shape: shape,
                          child: Text('Sair', style: button_text),
                          color: primary_color,
                          onPressed: () async {await this._controller.signOut(context);},
                        )
                      )
                    )
                  ]
                )
              ),
            )
          ),
        );
      },
    );
  }
}
