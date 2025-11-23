import 'dart:io';
import 'package:meta/meta.dart';
import 'package:upload_repository/upload_repository.dart';

@immutable
final class UploadRepositoryMockImpl implements UploadRepository {
  const UploadRepositoryMockImpl({
    this.delay = const Duration(milliseconds: 800),
  });

  final Duration delay;

  @override
  Future<UploadMultipleModel> uploadMultipleFiles(
    UploadEnumParam type,
    List<File> files,
  ) async {
    await Future<void>.delayed(delay);

    final urls = files.asMap().entries.map((entry) {
      final index = entry.key;
      return UploadDataModel(
        url: 'https://example.com/uploads/${type.name}/file_$index${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
    }).toList();

    return UploadMultipleModel(
      success: true,
      data: urls,
    );
  }

  @override
  Future<UploadSingleModel> uploadSingleFile(
    UploadEnumParam type,
    File file,
  ) async {
    await Future<void>.delayed(delay);

    // Симуляция загрузки файла
    final fileName = file.path.split('/').last;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = fileName.split('.').last;

    return UploadSingleModel(
      success: true,
      data: UploadDataModel(
        url: 'https://example.com/uploads/${type.name}/$timestamp.$extension',
      ),
    );
  }

  @override
  Future<Map<String, String>> uploadWithKeys(
    UploadEnumParam type,
    Map<String, File> files,
  ) async {
    await Future<void>.delayed(delay);

    final result = <String, String>{};
    for (final entry in files.entries) {
      final key = entry.key;
      final file = entry.value;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = file.path.split('.').last;

      result[key] = 'https://example.com/uploads/${type.name}/${key}_$timestamp.$extension';
    }

    return result;
  }
}
