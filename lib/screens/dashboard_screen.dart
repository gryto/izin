import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../bloc/dashboard/dahsboard_cubit.dart';
import '../bloc/dashboard/dashboard_state.dart';
import 'components/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => DashboardCubit(),
        child: BlocConsumer<DashboardCubit, DashboardState>(
            listener: (BuildContext context, DashboardState state) {
          if (state.isStartAnimation) {
            context.read<DashboardCubit>().resetAnimation();
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Bagian Card di bawah
                  AnimationLimiter(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: state.menu.asMap().entries.map((entry) {
                        int index = entry.key;
                        var item = entry.value;
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: SlideAnimation(
                            curve: Curves.bounceIn,
                            verticalOffset: 100.0,
                            child: DashboardCard(
                                icon: item.icon,
                                title: item.title,
                                subtitle: '',
                                color: item.color,
                                onClick: () {
                                  context
                                      .read<DashboardCubit>()
                                      .clickMenu(item.title, context);
                                }, colorbg: Colors.white, colorTitle: Colors.black,),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
