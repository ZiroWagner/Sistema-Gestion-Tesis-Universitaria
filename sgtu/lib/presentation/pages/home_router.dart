import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/app_state/app_state_bloc.dart';
import 'admin/admin_dashboard.dart';
import 'student/student_dashboard.dart';
import 'advisor/advisor_dashboard.dart';
import 'reviewer/reviewer_dashboard.dart';

class HomeRouter extends StatelessWidget {
  const HomeRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppStateBloc, AppState>(
      builder: (context, state) {
        if (state is AppStateLoaded) {
          final user = state.user;
          switch (user.rol) {
            case 'admin':
              return AdminDashboard(user: user);
            case 'estudiante':
              return StudentDashboard(user: user);
            case 'asesor':
              return AdvisorDashboard(user: user);
            case 'dictaminador':
              return ReviewerDashboard(user: user);
            default:
              return Scaffold(
                body: Center(
                  child: Text('Rol no reconocido: ${user.rol}'),
                ),
              );
          }
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}