import 'dart:io';
import 'package:api_client/clients/api_client.dart';
import 'package:meta/meta.dart';
import 'package:upload_repository/upload_repository.dart';

@immutable
final class UploadRemoteDataSource {
  const UploadRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<UploadSingleModel> uploadSingleFile(UploadEnumParam type, File file) {
    return apiClient.postType<UploadSingleModel>(
      '/api/v1/upload/single?type=${type.name}',
      data: {'file': file},
      fromJson: UploadSingleModel.fromJson,
    );
  }

  Future<UploadMultipleModel> uploadMultipleFiles(UploadEnumParam type, List<File> files) {
    return apiClient.postType<UploadMultipleModel>(
      '/api/v1/upload/multiple?type=${type.name}',
      data: {'files': files},
      fromJson: UploadMultipleModel.fromJson,
    );
  }

  Future<Map<String, String>> uploadWithKeys(
    UploadEnumParam type,
    Map<String, File> files,
  ) async {
    final json = await apiClient.post<Map<String, dynamic>>(
      '/api/v1/upload/with-keys?type=${type.name}',
      data: files,
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
