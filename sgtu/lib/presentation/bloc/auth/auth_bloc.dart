import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/failures.dart';
import '../../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final result = await loginUseCase.execute(
          event.email,
          event.password,
        );

        result.fold(
              (failure) {
            print('Error en AuthBloc: ${failure.message}');
            if (failure is TimeoutFailure) {
              emit(AuthError(message: 'La conexión tardó demasiado. Por favor, inténtalo de nuevo. ${failure.message}'));
            } else if (failure is ServerFailure) {
              emit(AuthError(message: 'Error del servidor. Por favor, inténtalo de nuevo. ${failure.message}'));
            } else {
              emit(AuthError(message: 'Error al iniciar sesión. Por favor, inténtalo de nuevo. ${failure.message}'));
            }
          },
              (user) => emit(AuthSuccess(user: user)),
        );
      } catch (e) {
        print('Error inesperado en AuthBloc: $e');
        emit(const AuthError(message: 'Ocurrió un error inesperado. Por favor, inténtalo de nuevo.'));
      }
    });

    on<LogoutRequested>((event, emit) {
      emit(AuthInitial());
    });
  }
}