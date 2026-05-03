import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/settings_repository.dart';

class GetTheme implements UseCase<bool, NoParams> {
  final SettingsRepository repository;
  GetTheme(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getIsDarkMode();
  }
}

class SetTheme implements UseCase<void, bool> {
  final SettingsRepository repository;
  SetTheme(this.repository);

  @override
  Future<Either<Failure, void>> call(bool params) async {
    return await repository.setIsDarkMode(params);
  }
}

class GetLanguage implements UseCase<String, NoParams> {
  final SettingsRepository repository;
  GetLanguage(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.getLanguage();
  }
}

class SetLanguage implements UseCase<void, String> {
  final SettingsRepository repository;
  SetLanguage(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.setLanguage(params);
  }
}
