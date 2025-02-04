import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/atk/atk_cubit.dart';
import '../../bloc/atk/atk_state.dart';

class DashboardAtk extends StatefulWidget {
  const DashboardAtk({super.key});

  @override
  State<DashboardAtk> createState() => _DashboardAtkState();
}

class _DashboardAtkState extends State<DashboardAtk> {
  late AtkCubit atkCubit;

  @override
  void initState() {
    super.initState();
    atkCubit = context.read<AtkCubit>();
    atkCubit.initData(context);
    print("stlh initdata");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AtkCubit, AtkState>(
        listener: (BuildContext context, AtkState state) {},
        builder: (context, state) {
          var dashboardAtkRequest =
              state.dashboardAtkRequest; // DashboardAtkAll object

          var dataList = [
            {
              'title': 'Total Request',
              'count': dashboardAtkRequest!.total ??
                  "0", // Mengakses properti langsung
              'icon': Icons.account_box,
              'color': Color.fromARGB(255, 114, 61, 248)
            },
            {
              'title': 'Done',
              'count': dashboardAtkRequest.done ??
                  "0", // Mengakses properti langsung
              'icon': Icons.list_outlined,
              'color': Color.fromARGB(255, 61, 131, 248)
            },
            {
              'title': 'Approved',
              'count': dashboardAtkRequest.approved ??
                  "0", // Mengakses properti langsung
              'icon': Icons.done_all_outlined,
              'color': Color.fromARGB(255, 12, 159, 111)
            },
            {
              'title': 'Pending',
              'count': dashboardAtkRequest.pending ??
                  "0", // Mengakses properti langsung
              'icon': Icons.pause_circle_outline,
              'color': Color.fromARGB(255, 240, 205, 78)
            },
            {
              'title': 'Rejected',
              'count': dashboardAtkRequest.rejected ??
                  "0", // Mengakses properti langsung
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  item['count'].toString(), // Menggunakan count
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
