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
