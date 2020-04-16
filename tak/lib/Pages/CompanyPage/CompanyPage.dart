
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tak/Controllers/CompanyPageControllers/CompanyController.dart';
import 'package:tak/Theme/theme.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>{
  
  final CompanyController _controller = CompanyController();
  final GlobalKey _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this._controller.getCompany();
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
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
                icon: Icon(this._controller.getIcon(), color: background_color, size: 30,),
                onPressed: (){
                  if(this._controller.getEditMode()){
                    this._controller.setEditMode(false);
                  }else{
                    this._controller.setEditMode(true);
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
              key: this._key,
              autovalidate: this._controller.getAutoValidate(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.account, size: 30, color: decoration_color),
                      hintText: 'Nome da Empresa'
                    ),
                    initialValue: this._controller.getName(),
                    onSaved: (String value){this._controller.setName(value);},
                    validator: (String value) 
                        => (value.length >= 10)? null : 'Mínimo de 10 caracteres' ,
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.badgeAccountHorizontalOutline, size: 30, color: decoration_color),
                      hintText: 'CNPJ'
                    ),
                    initialValue: this._controller.getCNPJ(),
                    onSaved: (String value){this._controller.setCNPJ(value);},
                   // validator: (String value) 
                   //   =>,
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.phone, size: 30, color: decoration_color),
                      hintText: 'Número de Telefone'
                    ),
                    initialValue: this._controller.getPhoneNumber(),
                    onSaved: (String value){this._controller.setPhoneNumber(value);},
                    validator: (String value){
                      if(value.length < 11){
                        return 'Precisa ter 11 dígitos';
                      }else{
                        List ddd = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 73, 74, 75, 77, 79, 81, 82, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 96, 97, 98, 99];
                        String s = value[0]+value[1];
                        int n = int.parse(s);
                        if(ddd.lastIndexOf(n) != -1){
                          return null;
                        }else{
                          return 'DDD inválido';
                        }
                      }
                    }
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.at, size: 30, color: decoration_color),
                      hintText: 'Email'
                    ),
                    initialValue: this._controller.getEmail(),
                    onSaved: (String value){this._controller.setEmail(value);},
                    validator: (String value){
                      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if(!regex.hasMatch(value)){
                        return 'Email inválido';
                      }
                      return null;
                    } 
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.lock, size: 30, color: decoration_color),
                      hintText: 'Senha'
                    ),
                    initialValue: this._controller.getPassword(),
                    onSaved: (String value){this._controller.setPassword(value);},
                    validator: (String value) => (value.length >= 8)? null : 'Mínimo de 8 caracteres',
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