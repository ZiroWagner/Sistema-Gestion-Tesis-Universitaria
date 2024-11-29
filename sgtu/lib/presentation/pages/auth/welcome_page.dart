import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050522),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/welcome.png',
                  height: 400,
                ),
                const SizedBox(height: 25),
                Text(
                  'SGTU',
                  style: GoogleFonts.righteous(
                    fontSize: 32,        // Tamaño de la fuente
                    fontWeight: FontWeight.w500,  // Peso de la fuente
                    color: Color(0xFFFC2B45),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sitema de Gestion y Seguimiento de Tesis Universitaria - UPeU',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 73),
                ElevatedButton(
                  onPressed: () {
                    // Implementar navegación a registro
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEB052),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Create Account',
                    style: GoogleFonts.righteous(
                      color: Color(0xFF050522),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFEB052), width: 3),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                    ),
                  ).copyWith(
                    // Cambiar el estilo cuando el botón está presionado
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.pressed)) {
                        // Cambia el color de fondo cuando está presionado
                        return Color(0xFFFEB052).withOpacity(0.2); // Color más suave o algún otro color
                      }
                      return Colors.transparent; // Color de fondo por defecto
                    }),
                  ),
                  child: Text(
                    'Login',
                    style: GoogleFonts.righteous(
                      color: Color(0xFFFEB052),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                const Text(
                  'All Right Reserved @2024',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFEB052),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}