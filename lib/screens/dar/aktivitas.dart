import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/dar/dar_cubit.dart';
import '../../bloc/dar/dar_state.dart';

class Aktivitas extends StatefulWidget {
  const Aktivitas({super.key});

  @override
  State<Aktivitas> createState() => _AktivitasState();
}

class _AktivitasState extends State<Aktivitas> {
  late DarCubit darCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    darCubit = context.read<DarCubit>();
    darCubit.initData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DarCubit, DarState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.warningMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.warningMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              state.tasks.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return ListTile(
                            title: Text('Task: ${task.task}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${task.id}'),
                                Text('Start Date: ${task.startDate}'),
                                Text('End Date: ${task.endDate}'),
                                Text('Status: ${task.status}'),
                              ],
                            ),
                            trailing: DropdownButton<String>(
                              value: task.status,
                              items: ['progress', 'completed'].map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                );
                              }).toList(),
                              onChanged: (newStatus) {
                                if (newStatus != null) {
                                  context
                                      .read<DarCubit>()
                                      .updateStatus(task.id, newStatus);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        Image.asset("assets/images/no_task.jpg"),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Anda belum memiliki tugas, hubungi atasan anda untuk assign task',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }
}
