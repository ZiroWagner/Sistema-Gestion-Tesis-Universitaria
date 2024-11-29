import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';
import '../../widgets/dashboard/profile_card.dart';
import '../../widgets/dashboard/bottom_nav_bar.dart';
import '../../widgets/dashboard/custom_app_bar.dart';

class AdminDashboard extends StatefulWidget {
  final User user;

  const AdminDashboard({super.key, required this.user});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050522),
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          ProfileCard(user: widget.user),
          // Aquí irá el contenido específico del administrador
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