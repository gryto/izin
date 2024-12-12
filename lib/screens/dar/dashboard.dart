import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/dar/dar_cubit.dart';
import '../../bloc/dar/dar_state.dart';

class DashboardDar extends StatefulWidget {
  const DashboardDar({super.key});

  @override
  State<DashboardDar> createState() => _DashboardDarState();
}

class _DashboardDarState extends State<DashboardDar> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarCubit, DarState>(builder: (context, state) {
      return Scaffold(
          body: Center(child: Text('Halaman Dashboard'),));
    });
  }
}

// ListTile(
//                       selected: state.currentScreen == 'Dashboard',
//                       leading: const Icon(Icons.dashboard),
//                       title: const Text('Dashboard'),
//                       onTap: () {
//                         _navigateTo("Dashboard");
//                       },
//                     ),
//                     ListTile(
//                       selected: state.currentScreen == 'Aktivitas',
//                       leading: const Icon(Icons.timeline),
//                       title: const Text('Aktivitas'),
//                       onTap: () {
//                         _navigateTo("Aktivitas");
//                       },
//                     ),
//                     ListTile(
//                       selected: state.currentScreen == 'Paket',
//                       leading: const Icon(Icons.card_giftcard),
//                       title: const Text('Paket'),
//                       onTap: () {
//                         _navigateTo("Paket");
//                       },
//                     ),