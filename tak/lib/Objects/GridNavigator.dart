import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GridNavigator{
  String name;
  IconData icon;
  String page;

  GridNavigator({this.name, this.icon, this.page});
}

// Lista de opções do Grid na HomePage
List<GridNavigator> routes = [
  new GridNavigator(name: 'Vender', icon: MdiIcons.cashUsdOutline, page: '/newSale'),
  new GridNavigator(name: 'Relatórios', icon: MdiIcons.chartLine),
  new GridNavigator(name: 'Itens', icon: MdiIcons.packageVariantClosed, page: '/listItems'),
  new GridNavigator(name: 'Perfil', icon: MdiIcons.account, page: '/company'),
  new GridNavigator(name: 'Contato', icon: MdiIcons.androidMessages),
  new GridNavigator(name: 'Manual', icon: MdiIcons.youtube)
];