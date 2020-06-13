import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Nav{
  String name;
  IconData icon;
  String page;
  bool completeDataRequired;

  Nav({this.name, this.icon, this.page, this.completeDataRequired});
}

// Lista de opções do Grid na HomePage
final List<Nav> homeRoutes = [
  new Nav(name: 'Vender', icon: MdiIcons.cashUsdOutline, page: '/newSale', completeDataRequired: true),
  new Nav(name: 'Relatórios', icon: MdiIcons.chartLine, page: '/salesReport', completeDataRequired: false),
  new Nav(name: 'Recibos', icon: MdiIcons.receipt, page: '/listInvoices', completeDataRequired: false),
  new Nav(name: 'Itens', icon: MdiIcons.packageVariantClosed, page: '/listItems', completeDataRequired: true),
  new Nav(name: 'Perfil', icon: MdiIcons.account, page: '/company', completeDataRequired: false),
  new Nav(name: 'Ajuda', icon: MdiIcons.helpCircleOutline, page: '/help', completeDataRequired: false),
  // new Nav(name: 'Contato', icon: MdiIcons.androidMessages),
  // new Nav(name: 'Manual', icon: MdiIcons.youtube)
];

// Lista de opções da Lista na HelpPage
final List<Nav> helpRoutes = [
  new Nav(name: 'Contato', icon: MdiIcons.androidMessages),
 // new Nav(name: 'Manual', icon: MdiIcons.youtube),
  new Nav(name: 'Sobre', icon: MdiIcons.helpCircleOutline, page: '/help/about'),
];
