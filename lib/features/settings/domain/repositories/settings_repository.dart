import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> getIsDarkMode();
  Future<Either<Failure, void>> setIsDarkMode(bool isDark);
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, void>> setLanguage(String langCode);
}
