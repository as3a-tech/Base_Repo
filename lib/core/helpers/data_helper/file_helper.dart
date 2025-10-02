import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileHelper {
  static Future<PlatformFile?> pickFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    bool allowMultiple = false,
  }) async {
    FilePickerResult? picker = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: type,
      allowedExtensions: allowedExtensions,
    );

    if (picker != null) {
      return picker.files.single;
    }
    return null;
  }

  static Future<XFile?> pickMedia({
    ImageSource source = ImageSource.gallery,
    ImagePickerType type = ImagePickerType.image,
  }) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? picker = switch (type) {
      ImagePickerType.image => await imagePicker.pickImage(source: source),
      ImagePickerType.video => await imagePicker.pickVideo(source: source),
      ImagePickerType.media => await imagePicker.pickMedia(),
    };
    if (picker != null) {
      return picker;
    }
    return null;
  }
}

enum ImagePickerType { image, video, media }
