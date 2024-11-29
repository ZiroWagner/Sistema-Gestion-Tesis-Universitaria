import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../bloc/profile/profile_state.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/dashboard/bottom_nav_bar.dart';
import '../../widgets/dashboard/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _correoController;
  late TextEditingController _telefonoController;
  late TextEditingController _dniController;
  late TextEditingController _passwordController;
  XFile? _selectedImage;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.user.nombre);
    _apellidoController = TextEditingController(text: widget.user.apellido);
    _correoController = TextEditingController(text: widget.user.correo);
    _telefonoController = TextEditingController(text: widget.user.telefono);
    _dniController = TextEditingController(text: widget.user.dni);
    _passwordController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  String _getRoleInSpanish(String role) {
    switch (role) {
      case 'admin':
        return 'Administrador';
      case 'estudiante':
        return 'Estudiante';
      case 'asesor':
        return 'Asesor';
      case 'dictaminador':
        return 'Dictaminador';
      default:
        return role;
    }
  }
  int _currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: const Color(0xFF050522),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFC2B45),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: _selectedImage != null
                                ? FileImage(File(_selectedImage!.path))
                                : (widget.user.imgRuta != null
                                    ? NetworkImage(widget.user.imgRuta!)
                                    : null) as ImageProvider?,
                            child: (_selectedImage == null && widget.user.imgRuta == null)
                                ? Text(
                                '${widget.user.nombre[0]}${widget.user.apellido[0]}',
                                  style: const TextStyle(fontSize: 30),
                                )
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                                onPressed: _pickImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${widget.user.nombre} ${widget.user.apellido}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getRoleInSpanish(widget.user.rol),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nombres',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _nombreController,
                            hintText: 'Nombres',
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Apellido',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _apellidoController,
                            hintText: 'Apellido',
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Correo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _correoController,
                            hintText: 'Correo',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Teléfono',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _telefonoController,
                            hintText: 'Teléfono',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'DNI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _dniController,
                            hintText: 'DNI',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Contraseña',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _showPassword ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Contraseña',
                            obscureText: !_showPassword,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is ProfileLoading
                                  ? null
                                  : () {
                                context.read<ProfileBloc>().add(
                                  UpdateProfileRequested(
                                    id: widget.user.id.toString(),
                                    nombre: _nombreController.text,
                                    apellido: _apellidoController.text,
                                    correo: _correoController.text,
                                    telefono: _telefonoController.text,
                                    dni: _dniController.text,
                                    password: _passwordController.text.isNotEmpty
                                        ? _passwordController.text
                                        : null,
                                    imagen: _selectedImage?.path,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF8696BB),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: state is ProfileLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                'Guardar cambios',
                                style: GoogleFonts.righteous(
                                  color: Color(0xFF050522),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        user: widget.user,
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _dniController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}