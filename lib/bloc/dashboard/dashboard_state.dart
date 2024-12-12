import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class DashboardState extends Equatable {
  final bool isStartAnimation;
  final bool isResetAnimation;
  final List<ChartData> chartData;
  final List<User> userData;
  final List<Menu> menu;

  DashboardState({
    this.isStartAnimation = false,
    this.isResetAnimation = false,
    List<ChartData>? chartData, // Ubah chartData menjadi parameter opsional
    List<User>? userData,
    List<Menu>? menu,
  })  : chartData = chartData ??
            [
              ChartData(DateTime(2024, 1, 1), 35),
              ChartData(DateTime(2024, 2, 1), 28),
              ChartData(DateTime(2024, 3, 1), 34),
              ChartData(DateTime(2024, 4, 1), 32),
              ChartData(DateTime(2024, 5, 1), 40),
            ], // Beri nilai default di sini jika chartData null
        userData = userData ??
            [
              // Beri nilai default di sini jika userData null
              User(),
              User(),
            ],
        menu = menu ??
            const [
              Menu(Icons.work_history, 'DAR', Colors.purple),
              Menu(Icons.check_box_rounded, 'Form Izin', Colors.indigo),
              Menu(Icons.inventory, 'Asset & ATK', Colors.orange),
              Menu(
                  Icons.request_quote_outlined, 'ATK Permintaan', Colors.green),
              Menu(Icons.shopping_cart, 'CA', Colors.blue),
              Menu(Icons.event, 'Event', Colors.teal),
            ];

  DashboardState copyWith({
    bool? isStartAnimation,
    bool? isResetAnimation,
    List<ChartData>?
        chartData, // Tambahkan chartData di sini jika ingin mengganti datanya
    List<Menu>? menu,
  }) {
    return DashboardState(
      isStartAnimation: isStartAnimation ?? this.isStartAnimation,
      isResetAnimation: isResetAnimation ?? this.isResetAnimation,
      chartData: chartData ?? this.chartData, // Tambahkan chartData ke copyWith
      menu: menu ?? this.menu,
    );
  }

  @override
  List<Object> get props =>
      [isStartAnimation, isResetAnimation, chartData, menu];
}

class ChartData {
  const ChartData(this.x, this.y); // Tetapkan constructor sebagai const
  final DateTime x;
  final double y;
}

// class User {
//   const User(this.nama, this.umur);
//   final String nama;
//   final int umur;
// }

class Menu {
  const Menu(this.icon, this.title, this.color);
  final IconData icon;
  final String title;
  final Color color;
}
