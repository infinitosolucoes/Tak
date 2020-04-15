
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
                icon: Icon(MdiIcons.leadPencil, color: background_color, size: 30,),
                onPressed: (){}
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.account, size: 30, color: decoration_color),
                      hintText: 'Nome da Empresa'
                    ),
                    initialValue: this._controller.getName(),
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.badgeAccountHorizontalOutline, size: 30, color: decoration_color),
                      hintText: 'CNPJ'
                    ),
                    initialValue: this._controller.getCNPJ(),
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.phone, size: 30, color: decoration_color),
                      hintText: 'Número de Telefone'
                    ),
                    initialValue: this._controller.getPhoneNumber(),
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.at, size: 30, color: decoration_color),
                      hintText: 'Email'
                    ),
                    initialValue: this._controller.getEmail(),
                  ),
                  TextFormField(
                    enabled: this._controller.getEditMode(),
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(MdiIcons.lock, size: 30, color: decoration_color),
                      hintText: 'Senha'
                    ),
                    initialValue: this._controller.getPassword(),
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