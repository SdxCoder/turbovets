import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../errors/failures.dart';
import '../../errors/result.dart';

@lazySingleton
class MediaPickerService {
  MediaPickerService(this._imagePicker);

  final ImagePicker _imagePicker;

  Future<Result<XFile>> pickImageFromGallery() async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (xFile == null) {
        return Result.failure(const ImagePickCancelledFailure());
      }

      return Result.success(xFile);
    } catch (e) {
      return _handleImagePickerException(e);
    }
  }

  Future<Result<List<XFile>>> pickMultipleImagesFromGallery() async {
    try {
      final xFiles = await _imagePicker.pickMultiImage();

      if (xFiles.isEmpty) {
        return Result.failure(const ImagePickCancelledFailure());
      }

      return Result.success(xFiles);
    } catch (e) {
      return _handleImagePickerException(e);
    }
  }

  Future<Result<XFile>> pickImageFromCamera() async {
    try {
      final xFile = await _imagePicker.pickImage(source: ImageSource.camera);

      if (xFile == null) {
        return Result.failure(const ImagePickCancelledFailure());
      }

      return Result.success(xFile);
    } catch (e) {
      return _handleImagePickerException(e);
    }
  }

  Result<T> _handleImagePickerException<T>(Object error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('permission') ||
        errorString.contains('denied') ||
        errorString.contains('authorized')) {
      return Result.failure(const ImagePickPermissionDeniedFailure());
    }

    return Result.failure(ImagePickPlatformFailure());
  }
}
