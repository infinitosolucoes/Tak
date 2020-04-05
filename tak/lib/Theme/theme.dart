import 'package:flutter/material.dart';

// Paleta de Cores
const Color background_color = Color(0xFFFEFEFE);
const Color primary_color = Color(0xFF359FF4);
const Color danger_color = Color(0xFFF44236);
const Color decoration_color = Color(0xFF9D9D9D);

// Estilização de fontes
  // Home
 // const TextStyle title_grid = TextStyle(fontFamily: 'Open Sans',fontSize: 20);
  TextStyle titleGrid(double height) => TextStyle(fontFamily: 'Open Sans',fontSize: (height*0.025));

  // Itens
  const TextStyle title_item = TextStyle(fontFamily: 'Open Sans',fontSize: 24,fontWeight: FontWeight.bold);
  const TextStyle subtitle_item = TextStyle(fontFamily: 'Open Sans',fontSize: 24,color: decoration_color);

  // AppBar
  const TextStyle home_app_bar = TextStyle(fontFamily: 'Merienda One',fontSize: 30,color: background_color);
  const TextStyle app_bar = TextStyle(fontFamily: 'Open Sans',fontSize: 25,color: background_color, fontWeight: FontWeight.normal);