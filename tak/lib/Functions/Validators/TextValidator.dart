
// Função pra validar o nome e os campos de endereço               
String textValidator(String value, int length) => (value.length >= length)? null : 'Mínimo de $length caracteres';
