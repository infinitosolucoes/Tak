import 'dart:convert';

import 'package:image_picker/image_picker.dart';

Future<String> imagePicker(double maxHeight, double maxWidth, int imageQuality) async{
  ImagePicker imagePicker = ImagePicker();
  PickedFile image = await imagePicker.getImage(
    source: ImageSource.gallery,
    maxHeight: maxHeight,
    maxWidth: maxWidth,
    imageQuality: imageQuality 
  );
  
  if(image != null){
    List<int> imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    
    print('\n Imagem: '+base64Image+'\n');
    return base64Image;
  }
  return null;
}