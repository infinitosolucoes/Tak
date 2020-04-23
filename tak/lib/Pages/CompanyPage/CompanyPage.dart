
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Controllers/CompanyPageControllers/CompanyController.dart';
import 'package:tak/Functions/Validators.dart' as Validators;
import 'package:tak/Theme/theme.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>{
  
  final CompanyController _controller = CompanyController();
  
  

  @override
  void dispose() {
    super.dispose();
    this._controller.close;
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
                onPressed: (){
                  if(this._controller.editMode){
                    if(this._controller.submit()){
                      this._controller.editMode = false;
                    }
                  }else{
                    this._controller.editMode = true;
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
                        onTap: this._controller.setImage,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  TextFormField(
                    enabled: this._controller.editMode,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.account, size: 30, color: decoration_color),
                      labelText: 'Nome Fantasia',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.name,
                    onSaved: (String value){this._controller.name = value;},
                    validator: Validators.nameValidator,
                  ),

                  TextFormField(
                    enabled: this._controller.editMode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.badgeAccountHorizontalOutline, size: 30, color: decoration_color),
                      labelText: 'CNPJ',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.cnpj,
                    maxLength: 14,
                    onSaved: (String value){this._controller.cnpj = value;},
                    validator: Validators.cnpjValidator,  
                  ),

                  TextFormField(
                    enabled: this._controller.editMode,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.phone, size: 30, color: decoration_color),
                      labelText: 'Número de Telefone',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.phoneNumber,
                    maxLength: 11,
                    onSaved: (String value){this._controller.phoneNumber = value;},
                    validator: Validators.phoneValidator,
                  ),

                  TextFormField(
                    enabled: this._controller.editMode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.at, size: 30, color: decoration_color),
                      labelText: 'Email',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.email,
                    onSaved: (String value){this._controller.email = value;},
                    validator: Validators.emailValidator,
                  ),

                  TextFormField(
                    enabled: this._controller.editMode,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.lock, size: 30, color: decoration_color),
                      labelText: 'Senha',
                      errorStyle: TextStyle(color: danger_color),
                    ),
                    initialValue: this._controller.password,
                    onSaved: (String value){this._controller.password = value;},
                    validator: Validators.passwordValidator,
                  ),
                ],
              ),
            )
          )
        );
      },
    );
  }
}
