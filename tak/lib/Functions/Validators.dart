    // Calculadora dos dígitos verificadores do CNPJ
  String _calculateVD(String cnpj, List<int> weight, String vd){
    int counter = 0;
    for(int i = 0; i < weight.length; i++){
      int digit;
      if((vd != '') && (i == (weight.length - 1))){
        digit = int.tryParse(vd);
      }else{
        digit = int.tryParse(cnpj[i]);
      }
      if(digit == null){return null;}
      counter += digit * weight[i];
    }
    counter %= 11;
    if(counter >= 2){
      return (11-counter).toString();
    }else{
      return (0).toString();
    }
  }

  // Função pra validar o nome               
  String nameValidator(String value) => (value.length >= 2)? null : 'Mínimo de 2 caracteres';

  // Função de validação do CNPJ
  String cnpjValidator(String value){
    if(value.length < 14){
      return 'Precisa de 14 dígitos';
    }else if(value == ('0'*14)){
      return 'CNPJ Inválido';
    }else{
      List<int> weight1 = [5,4,3,2,9,8,7,6,5,4,3,2];
      List<int> weight2 = [6,5,4,3,2,9,8,7,6,5,4,3,2];
      String vd = '';

      String s = _calculateVD(value,weight1,vd);
      if(s == null){return 'CNPJ Inválido';}
      vd = vd + s;
      s = _calculateVD(value,weight2,vd);
      if(s == null){return 'CNPJ Inválido';}
      vd = vd + s;

      if(int.parse(vd) == int.parse(value.substring((value.length - 2),value.length))){
        return null;
      }else{
        return 'CNPJ Inválido';
      }
    }
  }

  // Função de Validação de Telefone
  String phoneValidator(String value){
    if(value.length < 11){
      return 'Precisa ter 11 dígitos';
    }else{
      List ddd = [11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 73, 74, 75, 77, 79, 81, 82, 83, 84, 85, 86, 87, 88, 89, 91, 92, 93, 94, 95, 96, 97, 98, 99];
      String s = value[0]+value[1];
      int n = int.parse(s);
      if(ddd.lastIndexOf(n) != -1){
        return null;
      }else{
        return 'DDD inválido';
      }
    }
  }

  // Função de validação de email
  String emailValidator(String value){
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if(!regex.hasMatch(value)){
      return 'Email inválido';
    }
    return null;
  }

  // Função de validação de senha
  String passwordValidator(String value) => (value.length >= 8)? null : 'Mínimo de 8 caracteres';

  // Função de validação de preço
  String priceValidator(String value){

    for(var c in value.split('')){
      if('0123456789,'.indexOf(c) == -1){
        return 'Valor Inválido';
      }
    }
    if((value.split(',').length != 2) || (value.split(',')[1].length != 2)){
      return 'Valor Inválido';
    }
    // if(value.split(',')[1].length != 2){
    //   return 'Valor Inválido';
    // }
    String priceString = value.replaceAll(',', '.');
    
    double price = double.tryParse(priceString);
    if(price == null){
      return 'Valor Inválido';
    }
    if(price <= 0){
      return 'Valor Inválido';
    }
    return null;
  }

  // Função que calcula o Código de Barras, padrão EAN-13
  String ean13Validator(String value){
    if(value.length < 13){ 
      return 'Precisa de 13 Dígitos'; 
    }else if(value == ('0'*13)){ 
      return 'Código Inválido'; 
    }
    int counter = 0;
    bool flag = false;          // Bandeira de fazer a multiplicação por 1 (false) ou 3 (true)
    for (int index = 0; index < 12; index++) {
      int number = int.tryParse(value[index]);
      if(number == null){
        return 'Código Inválido';
      }else{
        if(flag){
          counter += number * 3; 
        }else{
          counter += number;
        }
        flag = !flag;           // Inverte o valor da bandeira
      }
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
    if(vdValue == null){
      return 'Código Inválido';
    }else if(vd != vdValue){
      return 'Código Inválido';
    }else{
      return null;
    }

  } 

  String locationValidator(String value) => (value.length >= 5)? null : 'Mínimo de 5 caracteres';
  String houseNumberValidator(String value) => (value.length >= 1)? null : 'Mínimo de 1 caractere';

  
