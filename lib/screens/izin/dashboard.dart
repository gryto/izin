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
    izinCubit = context.read<IzinCubit>();
    izinCubit.initData(context);
    print("stlh initdata");
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: BlocConsumer<IzinCubit, IzinState>(
      listener: (BuildContext context, IzinState state) {},
      builder: (context, state) {
        // Pastikan data sudah terisi dan state adalah IzinLoadedState
        // if (state is IzinLoadedState) {
          var dashboardIzin = state.dashboardIzin;  // DashboardIzinAll object

          // List data yang akan ditampilkan di ListView
          var dataList = [
            {
              'title': 'Izin Disetujui',
              'count': dashboardIzin.allIzin,  // Mengakses properti langsung
              'icon': Icons.list,
              'color': Color.fromARGB(255, 61, 131, 248)
            },
            {
              'title': 'Izin Disetujui',
              'count': dashboardIzin.approveIzin,  // Mengakses properti langsung
              'icon': Icons.approval,
              'color': Color.fromARGB(255, 12, 159, 111)
            },
            {
              'title': 'Semua Izin',
              'count': dashboardIzin.failedIzin,  // Mengakses properti langsung
              'icon': Icons.cancel_outlined,
              'color': Color.fromARGB(255, 240, 81, 82)
            },
          ];

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  var item = dataList[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Card(
                      color: item['color'] as Color,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              item['icon'] as IconData?,
                              color: Colors.white60,
                              size: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item['count'].toString(),  // Menggunakan count
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item['title'] as String,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        // } else {
        //   return Center(child: CircularProgressIndicator());
        // }
      },
    ),
  );
}
}
