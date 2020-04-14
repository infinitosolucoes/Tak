import 'package:flutter/material.dart';

// Paleta de Cores
const Color background_color = Color(0xFFFEFEFE);
const Color primary_color = Color(0xFF359FF4);
const Color danger_color = Color(0xFFF44236);
const Color success_color = Color(0xFF00CC66);
const Color decoration_color = Color(0xFF9D9D9D);

// Forma de botões
RoundedRectangleBorder shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));

Divider divider =  Divider(height: 1, color: decoration_color);

// Estilização de fontes
  // Home
  TextStyle titleGrid(double height) => TextStyle(fontFamily: 'Open Sans',fontSize: (height*0.025));

  // Itens
  const TextStyle title_item = TextStyle(fontFamily: 'Open Sans',fontSize: 20, fontWeight: FontWeight.bold);
  const TextStyle subtitle_item = TextStyle(fontFamily: 'Open Sans',fontSize: 17, color: decoration_color);

  // AppBar
  const TextStyle home_app_bar = TextStyle(fontFamily: 'Merienda One',fontSize: 30,color: background_color);
  const TextStyle app_bar = TextStyle(fontFamily: 'Open Sans',fontSize: 25,color: background_color, fontWeight: FontWeight.normal);

  // Botões
  const TextStyle button_text = TextStyle(fontFamily: 'Open Sans',fontSize: 16, fontWeight: FontWeight.bold, color: background_color);

  // Textos Nova venda
  const TextStyle sale_title = TextStyle(fontFamily: 'Open Sans',fontSize: 25, fontWeight: FontWeight.bold);
  const TextStyle total_text = TextStyle(fontFamily: 'Open Sans',fontSize: 25, fontWeight: FontWeight.bold, color: primary_color);
  const TextStyle subtotal_text = TextStyle(fontFamily: 'Open Sans',fontSize: 18, fontWeight: FontWeight.bold, color: primary_color);