import 'package:equatable/equatable.dart';
import '../../../domain/entities/app_entity.dart';

abstract class AppsState extends Equatable {
  const AppsState();
  
  @override
  List<Object> get props => [];
}

class AppsInitial extends AppsState {}

class AppsLoading extends AppsState {}

class AppsLoaded extends AppsState {
  final List<AppEntity> apps;
  final List<AppEntity> filteredApps;

  const AppsLoaded({
    required this.apps,
    required this.filteredApps,
  });

  @override
  List<Object> get props => [apps, filteredApps];
}

class AppsError extends AppsState {
  final String message;

  const AppsError(this.message);

  @override
  List<Object> get props => [message];
}
