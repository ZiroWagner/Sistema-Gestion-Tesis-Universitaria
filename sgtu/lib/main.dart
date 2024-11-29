import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgtu/presentation/bloc/profile/profile_bloc.dart';
import 'core/api/dio_client.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/user_remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/update_profile_usecase.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/app_state/app_state_bloc.dart';
import 'presentation/pages/auth/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Hacer la barra de navegación transparente
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF050522), // Barra de navegación transparente
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    final userRemoteDataSource = UserRemoteDataSourceImpl(dioClient: DioClient(appStateBloc: AppStateBloc()));
    final userRepository = UserRepositoryImpl(remoteDataSource: userRemoteDataSource);
    final updateProfileUseCase = UpdateProfileUseCase(userRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            loginUseCase: LoginUseCase(
              AuthRepositoryImpl(
                remoteDataSource: AuthRemoteDataSourceImpl(
                  dioClient: DioClient(appStateBloc: AppStateBloc()),
                ),
              ),
            ),
          ),
        ),
        BlocProvider<AppStateBloc>(
          create: (context) => AppStateBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(updateProfileUseCase: updateProfileUseCase),
        )
      ],
      child: MaterialApp(
        title: 'SGTU',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const WelcomePage(),
      ),
    );
  }
}
