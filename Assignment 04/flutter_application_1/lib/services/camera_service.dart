import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class CameraService {
final ImagePicker _picker = ImagePicker();


Future<String> takePhotoAsBase64() async {
final XFile? photo = await _picker.pickImage(source: ImageSource.camera, maxWidth: 1024, maxHeight: 1024, imageQuality: 70);
if (photo == null) return '';
final bytes = await File(photo.path).readAsBytes();
return base64Encode(bytes);
}
}