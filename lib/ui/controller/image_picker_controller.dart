import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  Future<void> pick(XFile? image) async {
    _pickedImage = image;
    update();
  }
}
