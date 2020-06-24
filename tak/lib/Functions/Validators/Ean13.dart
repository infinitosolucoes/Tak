import 'package:tak/Functions/List/GetItems.dart';
import 'package:tak/Objects/Item.dart';

// Função que verifica se o Código de Barras, padrão EAN-13, é válido
Future<String> ean13Validator(String value, String before) async {

  if(value.length < 13){ 
    return 'Precisa de 13 Dígitos'; 
  }else if(value == ('0'*13)){ 
    return 'Código Inválido'; 
  }else if((await _ean13Exists(value)) && (value != before)){
    return 'Código já cadastrado';
  }


  int counter = 0;
  bool flag = false;          // Bandeira de fazer a multiplicação por 1 (false) ou 3 (true)

  for (int index = 0; index < 12; index++) {
    
    int number = int.tryParse(value[index]);
    int weight = 1;

    if(number == null){
      return 'Código Inválido';
    }

    if(flag){weight = 3;}
    
    counter += number * weight;
    
    flag = !flag;           // Inverte o valor da bandeira
    
  }

  int vd;
  if((counter % 10) == 0){
    vd = 0;
  }else{
    int number = (counter/10).truncate();  // Arredonda o valor pra baixo
    number = (number + 1) * 10; 
    vd = number - counter;
  }
  
  int vdValue = int.tryParse(value[(value.length - 1)]);  // Pega o digito verificador do código informado
  if((vdValue == null) || (vd != vdValue)){
    return 'Código Inválido';
  }

  return null;

}

// Função que verifica se o código informado já existe no sistema
Future<bool> _ean13Exists(String value) async {
  
  List<Item> items = await loadItems();
  List<bool> ean13Codes = List.generate(
    items.length, 
    (int index) => (value == items[index].id)? true: false
  );

  if(ean13Codes.contains(true)){return true;}
  return false;
}
