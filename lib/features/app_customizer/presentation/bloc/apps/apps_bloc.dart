import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_installed_apps.dart';
import 'apps_event.dart';
import 'apps_state.dart';

class AppsBloc extends Bloc<AppsEvent, AppsState> {
  final GetInstalledApps getInstalledApps;

  AppsBloc({required this.getInstalledApps}) : super(AppsInitial()) {
    on<LoadApps>(_onLoadApps);
    on<SearchApps>(_onSearchApps);
  }

  Future<void> _onLoadApps(LoadApps event, Emitter<AppsState> emit) async {
    emit(AppsLoading());
    final result = await getInstalledApps(NoParams());
    result.fold(
      (failure) => emit(AppsError(failure.message)),
      (apps) => emit(AppsLoaded(apps: apps, filteredApps: apps)),
    );
  }

  void _onSearchApps(SearchApps event, Emitter<AppsState> emit) {
    if (state is AppsLoaded) {
      final currentState = state as AppsLoaded;
      final query = event.query.toLowerCase();
      final filtered = currentState.apps
          .where((app) => app.name.toLowerCase().contains(query))
          .toList();
      emit(AppsLoaded(apps: currentState.apps, filteredApps: filtered));
    }
  }
}
