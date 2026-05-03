import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/app_entity.dart';
import '../../domain/repositories/app_repository.dart';
import '../datasources/app_local_data_source.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource localDataSource;

  AppRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<AppEntity>>> getInstalledApps() async {
    try {
      final apps = await localDataSource.getInstalledApps();
      return Right(apps);
    } catch (e) {
      return Left(PlatformFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createShortcut({
    required String name,
    required String package,
    required Uint8List icon,
  }) async {
    try {
      await localDataSource.createShortcut(
        name: name,
        package: package,
        icon: icon,
      );
      return const Right(null);
    } catch (e) {
      return Left(PlatformFailure(e.toString()));
    }
  }
}
