import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/app_entity.dart';
import '../repositories/app_repository.dart';

class GetInstalledApps implements UseCase<List<AppEntity>, NoParams> {
  final AppRepository repository;

  GetInstalledApps(this.repository);

  @override
  Future<Either<Failure, List<AppEntity>>> call(NoParams params) async {
    return await repository.getInstalledApps();
  }
}
