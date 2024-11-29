import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/update_profile_usecase.dart';
import '../../../core/error/failures.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileBloc({required this.updateProfileUseCase}) : super(ProfileInitial()) {
    on<UpdateProfileRequested>(_onUpdateProfileRequested);
  }

  Future<void> _onUpdateProfileRequested(
      UpdateProfileRequested event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
  try {
      final result = await updateProfileUseCase(UpdateProfileParams(
        id: event.id,
        nombre: event.nombre,
        apellido: event.apellido,
        correo: event.correo,
        telefono: event.telefono,
        dni: event.dni,
        password: event.password,
        imagen: event.imagen,
      ));

      result.fold(
            (failure) {
          print('Error en ProfileBloc:  ${failure.message}');
          if (failure is TimeoutFailure) {
            emit(const ProfileError(message: 'La conexión tardó demasiado. Por favor, inténtalo de nuevo.'));
          } else if (failure is ServerFailure) {
            emit(ProfileError(message: failure.message ?? 'Error del servidor. Por favor, inténtalo de nuevo.'));
          } else {
            emit(const ProfileError(message: 'Error al iniciar sesión. Por favor, inténtalo de nuevo.'));
          }
        },
            (_) => emit(const ProfileUpdateSuccess('Perfil actualizado exitosamente')),
      );
    }catch (e) {
      print('Error inesperado en ProfileBloc: $e');
      emit(const ProfileError(message: 'Ocurrió un error inesperado. Por favor, inténtalo de nuevo.'));
    }
  }
}