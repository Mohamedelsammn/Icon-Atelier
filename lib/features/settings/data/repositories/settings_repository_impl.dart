import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_data_source.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> getIsDarkMode() async {
    try {
      final isDark = await localDataSource.getIsDarkMode();
      return Right(isDark);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final lang = await localDataSource.getLanguage();
      return Right(lang);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setIsDarkMode(bool isDark) async {
    try {
      await localDataSource.setIsDarkMode(isDark);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setLanguage(String langCode) async {
    try {
      await localDataSource.setLanguage(langCode);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
