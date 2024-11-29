import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';

// Events
abstract class AppStateEvent extends Equatable {
  const AppStateEvent();

  @override
  List<Object> get props => [];
}

class AppStateInitialized extends AppStateEvent {
  final User user;

  const AppStateInitialized(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateToken extends AppStateEvent {
  final String token;
  const UpdateToken(this.token);

  @override
  List<Object> get props => [token];
}

// States
abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppStateInitial extends AppState {}

class AppStateLoaded extends AppState {
  final User user;
  final String? token;

  const AppStateLoaded(this.user, {this.token});

  @override
  List<Object> get props => [user, token ?? ''];

  AppStateLoaded copyWith({User? user, String? token}) {
    return AppStateLoaded(
      user ?? this.user,
      token: token ?? this.token,
    );
  }
}

// Bloc
class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  AppStateBloc() : super(AppStateInitial()) {
    on<AppStateInitialized>((event, emit) {
      emit(AppStateLoaded(event.user));
    });

    on<UpdateToken>((event, emit) {
      if (state is AppStateLoaded) {
        emit((state as AppStateLoaded).copyWith(token: event.token));
      }
    });
  }
  User? get currentUser => state is AppStateLoaded
      ? (state as AppStateLoaded).user
      : null;

  String? get token => currentUser?.token;
}