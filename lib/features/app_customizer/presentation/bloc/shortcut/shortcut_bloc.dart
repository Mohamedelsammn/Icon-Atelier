import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_shortcut.dart';
import 'shortcut_event.dart';
import 'shortcut_state.dart';

class ShortcutBloc extends Bloc<ShortcutEvent, ShortcutState> {
  final CreateShortcut createShortcut;

  ShortcutBloc({required this.createShortcut}) : super(ShortcutInitial()) {
    on<CreateShortcutEvent>(_onCreateShortcut);
  }

  Future<void> _onCreateShortcut(
      CreateShortcutEvent event, Emitter<ShortcutState> emit) async {
    emit(ShortcutLoading());
    final result = await createShortcut(CreateShortcutParams(
      name: event.name,
      package: event.package,
      icon: event.icon,
    ));
    result.fold(
      (failure) => emit(ShortcutError(failure.message)),
      (_) => emit(ShortcutSuccess(event.name)),
    );
  }
}
