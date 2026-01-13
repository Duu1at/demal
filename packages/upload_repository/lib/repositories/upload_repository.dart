import 'dart:io';
import 'package:upload_repository/upload_repository.dart';

abstract class UploadRepository {
  Future<UploadSingleModel> uploadSingleFile(UploadEnumParam type, File file);
  Future<UploadMultipleModel> uploadMultipleFiles(UploadEnumParam type, List<File> files);
  Future<Map<String, String>> uploadWithKeys(UploadEnumParam type, Map<String, File> files);
  Future<void> deleteFile(String url);
}
