import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../widgets/dashboard/custom_app_bar.dart';
import '../../widgets/dashboard/profile_card.dart';
import '../../widgets/dashboard/bottom_nav_bar.dart';

class StudentDashboard extends StatefulWidget {
  final User user;

  const StudentDashboard({super.key, required this.user});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050522),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          ProfileCard(user: widget.user),
          // Aquí irá el contenido específico del Estudiante
        ],
      ),
      bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          user: widget.user
      ),
    );
  }
}