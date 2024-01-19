import 'dart:io';

import 'package:image_picker/image_picker.dart';
class ImagePickerService{
static Future<File?> pickImage(ImageSource src) async {
  final ImagePicker picker = ImagePicker();
final XFile? image = await picker.pickImage(source: src);
if(image!=null){
  return File(image.path);
}
else {return null;}
}



}