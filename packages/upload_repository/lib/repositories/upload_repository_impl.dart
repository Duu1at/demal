import 'dart:io';
import 'package:meta/meta.dart';
import 'package:upload_repository/upload_repository.dart';

@immutable
final class UploadRepositoryImpl implements UploadRepository {
  const UploadRepositoryImpl(this.uploadRemoteDataSource);

  final UploadRemoteDataSource uploadRemoteDataSource;

  @override
  Future<UploadMultipleModel> uploadMultipleFiles(
    UploadEnumParam type,
    List<File> files,
  ) {
    return uploadRemoteDataSource.uploadMultipleFiles(type, files);
  }

  @override
  Future<UploadSingleModel> uploadSingleFile(
    UploadEnumParam type,
    File file,
  ) {
    return uploadRemoteDataSource.uploadSingleFile(type, file);
  }

  @override
  Future<Map<String, String>> uploadWithKeys(
    UploadEnumParam type,
    Map<String, File> files,
  ) {
    return uploadRemoteDataSource.uploadWithKeys(type, files);
  }
}
