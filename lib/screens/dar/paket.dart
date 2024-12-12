import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/dar/dar_cubit.dart';
import '../../bloc/dar/dar_state.dart';

class Paket extends StatefulWidget {
  const Paket({super.key});

  @override
  State<Paket> createState() => _PaketState();
}

class _PaketState extends State<Paket> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarCubit, DarState>(builder: (context, state) {
      return const Scaffold(
          body: Center(child: Text('Halaman Paket'),));
    });
  }
}