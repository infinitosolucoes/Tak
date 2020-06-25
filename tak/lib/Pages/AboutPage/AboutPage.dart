import 'package:flutter/material.dart';
import 'package:tak/Controllers/AboutPage/AboutPageController.dart';
import 'package:tak/Dict/Dictionary.dart';
import 'package:tak/Theme/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final AboutPageController _controller = new AboutPageController();

  @override
  void initState(){
    this._controller.initPackageInfo();
    super.initState();
  }


  @override
  void dispose(){
    this._controller.close;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: this._controller.output,
      builder: (context, snapshot){
        return Scaffold(
          backgroundColor: primary_color,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(phrases['companyLogo'], style: companyLogoAbout),
                Text('${phrases['version']} ${this._controller.packageInfo.version}', style: descriptionAbout),
                
                SizedBox(height: 50),
                
                
                Text(phrases['licenseAbout'], style: descriptionAbout, textAlign: TextAlign.center),
                SizedBox(height: 8),
                FlatButton(
                  color: background_color,
                  textColor: primary_color,
                  child: Text(phrases['licenseButton']),
                  onPressed: () async{await this._controller.showLicense(context);},
                ),
                SizedBox(height: 8),
                FlatButton(
                  color: background_color,
                  textColor: primary_color,
                  child: Text(phrases['terms'].toUpperCase()),
                  onPressed: () async {
                    if(await canLaunch(phrases['termsLink'])){
                      await launch(phrases['termsLink']);
                    }
                  },
                ),
                SizedBox(height: 8),
                FlatButton(
                  color: background_color,
                  textColor: primary_color,
                  child: Text(phrases['privacy'].toUpperCase()),
                  onPressed: () async{
                    if(await canLaunch(phrases['privacyLink'])){
                      await launch(phrases['privacyLink']);
                    }
                  },
                ),
              ],
            ),
          )
        );
      }
    );
  }


//   Future<void> _showLicense() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, 
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('BSD 3-Clause'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Copyright (c) 2020, Ricardo de Monteiro e Tavares - Evoluis Cooperativa de Programação.'),
//                 Text('Todos os direitos reservados.'),
//                 Text('A redistribuição e uso nas formas de origem e binárias, com ou sem modificação, são permitidas desde que as seguintes condições sejam atendidas:'),
//                 Text('1. As redistribuições do código-fonte devem manter o aviso de direitos autorais acima, esta lista de condições e o aviso de isenção de responsabilidade a seguir.'),
//                 Text('2. As redistribuições em formato binário devem reproduzir o aviso de direitos autorais acima, esta lista de condições e o aviso de isenção de responsabilidade a seguir na documentação e/ou outros materiais fornecidos com a distribuição.'),
//                 Text('3. Nem o nome do detentor dos direitos autorais nem os nomes de seus colaboradores podem ser utilizados para endossar ou promover produtos derivados deste software sem permissão prévia por escrito.'),

//                 Text('ESTE SOFTWARE É FORNECIDO PELOS TITULARES DE DIREITOS AUTORAIS E CONTRIBUIDORES "TAL COMO ESTÁ" E QUALQUER GARANTIA EXPRESSA OU IMPLÍCITA, INCLUINDO, MAS NÃO SE LIMITANDO A, AS GARANTIAS IMPLÍCITAS DE COMERCIALIZAÇÃO E ADEQUAÇÃO A UM PROPÓSITO ESPECÍFICO. EM NENHUM CASO, O TITULAR DIREITO DE DIREITOS AUTORAIS OU OS CONTRIBUIDORES SERÃO RESPONSÁVEIS POR QUALQUER DANO DIRETO, INDIRETO, INCIDENTAL, ESPECIAL, EXEMPLAR OU CONSEQÜENCIAL (INCLUINDO, MAS NÃO SE LIMITANDO A, AQUISIÇÃO DE BENS OU SERVIÇOS SUBSTITUTOS; PERDA DE USO, DADOS OU LUCROS DE USO; OU INTERRUPÇÃO DE NEGÓCIOS), CAUSADA E QUALQUER TEORIA DE RESPONSABILIDADE, CONTRATADA, RESPONSABILIDADE RIGA OU ATRIBUIÇÃO (INCLUINDO NEGLIGÊNCIA OU DE OUTRA FORMA), DE QUALQUER FORMA DE USO DO SOFTWARE, MESMO SE FOR AVISADO DA POSSIBILIDADE DE TAIS DADOS.')
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('FECHAR'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
}
