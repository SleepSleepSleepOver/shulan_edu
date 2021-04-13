import 'package:common_plugin/common_plugin.dart';

enum PickImageType {
  CAMERA,
  GALLERY,
}

class ImagePicker {
  ///选择单张图片
  Future pickerImage(PickImageType type) async {
    if (type == PickImageType.CAMERA) {
      return await ImagesPicker.openCamera();
    } else {
      return await ImagesPicker.pick(count: 1, pickType: PickType.image)
          .then((value) {
        if (value != null && value.length != 0) {
          return value;
        }
      });
    }
  }

  ///选择多张图片
  Future<List> pickerImages(PickImageType type, int count) async {
    if (type == PickImageType.CAMERA) {
      return ImagesPicker.openCamera();
    } else {
      return ImagesPicker.pick(count: count, pickType: PickType.image);
    }
  }

  ///保存到本地图片
  Future<bool> saveImageToAlbum(File file, {String albumName}) async {
    return await ImagesPicker.saveImageToAlbum(file, albumName: albumName);
  }
}
