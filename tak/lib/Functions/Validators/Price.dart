// Função de validação de preço no padrão brasileiro
String priceValidator(String value){

  // for(var c in value.split('')){
  //   if(!('0123456789,'.contains(c))){
  //     return 'Valor Inválido';
  //   }
  // }
  // if((value.split(',').length != 2) || (value.split(',')[1].length != 2)){
  //   return 'Valor Inválido';
  // }
  
  // String priceString = value.replaceAll(',', '.');
  
  // double price = double.tryParse(priceString);
  // if((price == null) || (price <= 0)){
  //   return 'Valor Inválido';
  // }
 
  // return null;

  RegExp exp = new RegExp(r"^(\d+\,\d{2})$");
  bool result = exp.hasMatch(value);
  if(result){return null;}
  return 'Valor Inválido';
}
