import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';
import '../utils/constants/colors.dart';
import 'components/text_input.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Navigasi ke layar lain jika login berhasil
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('Login berhasil!'),
              //     behavior: SnackBarBehavior.floating,
              //     margin: EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
              //   ),
              // );
              // cShowTopSnackBar(context, 'Login Berhasil!!!');
              // const TopSnackBar(message: 'Login Berhasil');
            }
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                    size: Size(
                        MediaQuery.of(context).size.width, 150), // Tinggi kurva
                    painter: CurvePainter(),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                    size: Size(
                        MediaQuery.of(context).size.width, 150), // Tinggi kurva
                    painter: CustomFormBottom(),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomPaint(
                    size: Size(
                        MediaQuery.of(context).size.width, 150), // Tinggi kurva
                    painter: CurveShadow(),
                  ),
                ),
                // Form Login
                Center(
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorApp.basic,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(3, 3),
                              blurRadius: 5,
                              spreadRadius: 2)
                        ]
                        // color: ColorApp.secondary.withOpacity(0.1),
                        ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/full-logo.png"),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: ColorApp.appNameColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 45,
                                    child: InputText(
                                      controller: _usernameController,
                                      icon: Icons.person_2_rounded,
                                    )),
                                const Gap(20),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 45,
                                    child: InputText(
                                      controller: _passwordController,
                                      isPassword: true,
                                      icon: Icons.visibility_off,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 20),
                            state.isLoading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final username =
                                            _usernameController.text;
                                        final password =
                                            _passwordController.text;
                                        context
                                            .read<LoginCubit>()
                                            .login(context, username, password);
                                        // Aksi login
                                      },
                                      style: ElevatedButton.styleFrom(
                                        // padding: const EdgeInsets.symmetric(
                                        //     horizontal: 50, vertical: 15),
                                        backgroundColor: ColorApp.materialDark,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ), // Warna hijau kebiruan
                                      ),
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ColorApp.third // Warna kurva
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5, size.height - 100, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomFormBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ColorApp.secondary // Warna kurva
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width, size.height - 100, size.width * 0.5, size.height);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomForm extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ColorApp.secondary // Warna kurvar
      ..style = PaintingStyle.fill;

    var path = Path();
    // Memulai dari kanan atas (size.width, 0)
    path.moveTo(size.width, 0);
    // Membuat kurva terbalik secara horizontal dan vertikal
    path.quadraticBezierTo(size.width * 0.5, 100, 0, size.height * 0.5);
    // Menghubungkan ke titik kanan bawah
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CurveShadow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ColorApp.basic // Warna kurva utama
      ..style = PaintingStyle.fill;

    var shadowPaint = Paint()
      ..color = Colors.blue.withOpacity(0.3) // Warna bayangan lebih transparan
      ..style = PaintingStyle.fill;

    // Path untuk bayangan (di belakang kurva utama)
    var shadowPath = Path();
    shadowPath.moveTo(size.width, 10); // Pindahkan sedikit ke bawah
    shadowPath.quadraticBezierTo(size.width * 0.5, 110, 0,
        size.height * 0.5 + 10); // Menggeser titik kontrol dan titik akhir
    shadowPath.lineTo(0, size.height);
    shadowPath.lineTo(size.width, size.height);
    shadowPath.close();

    // Menggambar bayangan terlebih dahulu
    canvas.drawPath(shadowPath, shadowPaint);

    // Path untuk kurva utama
    var path = Path();
    path.moveTo(size.width, 0);
    path.quadraticBezierTo(size.width * 0.5, 100, 0, size.height * 0.5);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    // Menggambar kurva utama di atas bayangan
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
