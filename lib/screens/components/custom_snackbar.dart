

import 'package:flutter/material.dart';

void cShowTopSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final animationController = AnimationController(
    vsync: Scaffold.of(context), // Menggunakan vsync dari Scaffold
    duration: const Duration(milliseconds: 500), // Durasi animasi masuk
  );

  // Animasi untuk slide dari atas ke bawah
  final slideAnimation = Tween<Offset>(
    begin: const Offset(0, -1), // Awalnya di luar layar (di atas)
    end: const Offset(0, 0), // Masuk ke posisi normal
  ).animate(CurvedAnimation(
    parent: animationController,
    curve: Curves.easeInOut,
  ));

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0, // Atur posisi di bagian atas layar
      left: 10.0,
      right: 10.0,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: slideAnimation,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ),
  );

  // Menambahkan Overlay
  overlay.insert(overlayEntry);

  // Menjalankan animasi saat snackbar muncul
  animationController.forward();

  // Menghilangkan overlay dengan animasi setelah beberapa detik
  Future.delayed(const Duration(seconds: 2), () async {
    await animationController.reverse(); // Reverse untuk menghilangkan animasi
    overlayEntry.remove(); // Hapus overlay setelah animasi selesai
  });
}
