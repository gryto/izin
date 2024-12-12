import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/izin/izin_cubit.dart';
import '../../bloc/izin/izin_state.dart';

class DashboardIzin extends StatefulWidget {
  const DashboardIzin({super.key});

  @override
  State<DashboardIzin> createState() => _DashboardIzinState();
}

class _DashboardIzinState extends State<DashboardIzin> {
  late IzinCubit izinCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    izinCubit = context.read<IzinCubit>();
    izinCubit.initData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<IzinCubit, IzinState>(
          listener: (BuildContext context, IzinState state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Bagian Card di bawah
                    Card(
                      color: const Color.fromARGB(255, 61, 131, 248),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.list,
                              color: Colors.white60,
                              size: 50,
                            ),
                            Column(children: [
                              Text(
                                state.dashboardIzin.allIzin != null
                                    ? state.dashboardIzin.allIzin.toString()
                                    : "0",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Izin Disetujui",
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      color: const Color.fromARGB(255, 12, 159, 111),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.approval,
                              color: Colors.white60,
                              size: 50,
                            ),
                            Column(children: [
                              Text(
                                state.dashboardIzin.approveIzin != null
                                    ? state.dashboardIzin.approveIzin.toString()
                                    : "0",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Izin Ditolak",
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      color: const Color.fromARGB(255, 240, 81, 82),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.cancel_outlined,
                              color: Colors.white60,
                              size: 50,
                            ),
                            Column(children: [
                              Text(
                                state.dashboardIzin.failedIzin != null
                                    ? state.dashboardIzin.failedIzin.toString()
                                    : "0",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Semua Izin",
                                style: TextStyle(color: Colors.white),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
