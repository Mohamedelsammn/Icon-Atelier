import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/app_entity.dart';

abstract class AppRepository {
  Future<Either<Failure, List<AppEntity>>> getInstalledApps();
  Future<Either<Failure, void>> createShortcut({
    required String name,
    required String package,
    required Uint8List icon,
  });
}
