import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/app_repository.dart';

class CreateShortcut implements UseCase<void, CreateShortcutParams> {
  final AppRepository repository;

  CreateShortcut(this.repository);

  @override
  Future<Either<Failure, void>> call(CreateShortcutParams params) async {
    return await repository.createShortcut(
      name: params.name,
      package: params.package,
      icon: params.icon,
    );
  }
}

class CreateShortcutParams extends Equatable {
  final String name;
  final String package;
  final Uint8List icon;

  const CreateShortcutParams({
    required this.name,
    required this.package,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, package, icon];
}
