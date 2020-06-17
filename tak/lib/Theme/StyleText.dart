import 'package:flutter/material.dart';
import 'Color.dart';

// Estilização de fontes
  // Home
  TextStyle titleGrid(double height) => TextStyle(fontFamily: 'Open Sans',fontSize: (height*0.025));

  // Itens
  const TextStyle title_item = TextStyle(fontFamily: 'Open Sans',fontSize: 20, fontWeight: FontWeight.bold);
  const TextStyle subtitle_item = TextStyle(fontFamily: 'Open Sans',fontSize: 17, color: decoration_color);

  // AppBar
  const TextStyle home_app_bar = TextStyle(fontFamily: 'Merienda One',fontSize: 30,color: background_color);
  const TextStyle app_bar = TextStyle(fontFamily: 'Open Sans',fontSize: 22,color: background_color, fontWeight: FontWeight.normal);

  // Botões
  const TextStyle button_text = TextStyle(fontFamily: 'Open Sans',fontSize: 16, fontWeight: FontWeight.bold, color: background_color);

  // Textos Nova venda
  const TextStyle sale_title = TextStyle(fontFamily: 'Open Sans',fontSize: 25, fontWeight: FontWeight.bold);
  const TextStyle total_text = TextStyle(fontFamily: 'Open Sans',fontSize: 25, fontWeight: FontWeight.bold, color: primary_color);
  const TextStyle subtotal_text = TextStyle(fontFamily: 'Open Sans',fontSize: 18, fontWeight: FontWeight.bold, color: primary_color);

  // Textos página de Relatório
  const TextStyle results = TextStyle(fontFamily: 'Open Sans',fontSize: 35, fontWeight: FontWeight.bold, color: primary_color);

  // Textos para a página de Login
  const TextStyle companyLogo = TextStyle(fontFamily: 'Merienda One',fontSize: 80,color: background_color);
  const TextStyle catchphrase =  TextStyle(fontFamily: 'Open Sans', fontSize: 18, color: background_color);