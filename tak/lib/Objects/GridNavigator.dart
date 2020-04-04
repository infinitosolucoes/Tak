import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GridNNavigator{
  String name;
  IconData icon;
  Widget page;

  GridNNavigator({this.name, this.icon, this.page});
}

// Lista de opções do Grid na HomePage
List<GridNNavigator> routes = [
  new GridNNavigator(name: 'Vender', icon: MdiIcons.cashUsdOutline),
  new GridNNavigator(name: 'Relatórios', icon: MdiIcons.chartLine),
  new GridNNavigator(name: 'Itens', icon: MdiIcons.packageVariantClosed),
  new GridNNavigator(name: 'Conta', icon: MdiIcons.account),
];