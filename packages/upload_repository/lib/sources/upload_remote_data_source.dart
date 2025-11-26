import 'dart:io';
import 'package:api_client/api_client.dart';
import 'package:meta/meta.dart';
import 'package:upload_repository/upload_repository.dart';

@immutable
final class UploadRemoteDataSource {
  const UploadRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<UploadSingleModel> uploadSingleFile(UploadEnumParam type, File file) async {
    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );

    final formData = FormData.fromMap({
      'file': multipartFile,
    });

    return apiClient.postType<UploadSingleModel>(
      '/api/v1/upload/single?type=${type.name}',
      data: formData,
      fromJson: UploadSingleModel.fromJson,
    );
  }

  Future<UploadMultipleModel> uploadMultipleFiles(UploadEnumParam type, List<File> files) async {
    final multipartFiles = await Future.wait(
      files.map((file) async {
        return MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );
      }),
    );

    final formData = FormData.fromMap({
      'files': multipartFiles,
    });

    return apiClient.postType<UploadMultipleModel>(
      '/api/v1/upload/multiple?type=${type.name}',
      data: formData,
      fromJson: UploadMultipleModel.fromJson,
    );
  }

  Future<Map<String, String>> uploadWithKeys(
    UploadEnumParam type,
    Map<String, File> files,
  ) async {
    final multipartFiles = await Future.wait(
      files.entries.map((entry) async {
        return MapEntry(
          entry.key,
          await MultipartFile.fromFile(
            entry.value.path,
            filename: entry.value.path.split('/').last,
          ),
        );
      }),
    );

    final formData = FormData.fromMap(
      Map.fromEntries(multipartFiles),
    );

    final json = await apiClient.post<Map<String, dynamic>>(
      '/api/v1/upload/with-keys?type=${type.name}',
      data: formData,
    );

    final data = json['data'];
    if (data is Map) {
      return data.map<String, String>(
        (key, value) => MapEntry(key.toString(), value as String),
      );
    }

    return <String, String>{};
  }
}
