import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:tak/Objects/Nav.dart';
import 'package:tak/Theme/theme.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: primary_color,
            centerTitle: true,
            title: Text('Ajuda', style: app_bar),
          ),
      backgroundColor: background_color,

      body: ListView.separated(
        itemCount: helpRoutes.length, 
        separatorBuilder: (context, index) => divider, 
        itemBuilder: (context, index){
          return ListTile(
            leading: Icon(helpRoutes[index].icon, color: primary_color, size: 30),
            title: Text(helpRoutes[index].name , style: subtitle_item),
            trailing: Icon(Icons.arrow_forward_ios, color: primary_color,),
            onTap: ()async{
              if(index == 0){
                final Email email = Email(
                  isHTML: false,
                  subject: 'Tak - Contato de suporte',
                  recipients: ['ricardotavares@id.uff.br'],   
                );

                await FlutterEmailSender.send(email);
              }
              Navigator.pushNamed(context, helpRoutes[index].page);
            },
          );
        }, 
      )
    );
  }
}
