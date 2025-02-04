import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/atk/atk_cubit.dart';
import '../../bloc/atk/atk_state.dart';
import '../../utils/constants/colors.dart';

class AtkScreen extends StatefulWidget {
  const AtkScreen({super.key});

  @override
  State<AtkScreen> createState() => _AtkScreenState();
}

class _AtkScreenState extends State<AtkScreen> {
  late AtkCubit atkCubit;
  @override
  void initState() {
    super.initState();
    atkCubit = context.read<AtkCubit>();
    atkCubit.initMenu();
    atkCubit.navigateTo('Dashboard', 0);
    print("dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AtkCubit, AtkState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.currentScreen),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: ColorApp.basic,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ...state.listMenu.asMap().entries.map(
                  (entry) {
                    int index = entry.key;
                    var menu = entry.value;
                    return ListTile(
                      selected: state.currentScreen == menu.title,
                      leading: menu.icon ?? const Icon(Icons.dangerous),
                      title: Text(menu.title ?? ''),
                      onTap: () {
                        context
                            .read<AtkCubit>()
                            .navigateTo(menu.title ?? '', index);
                        Navigator.pop(context);
                        print(menu.title);
                      },
                    );
                  },
                )
              ],
            ),
          ),
          body: state.listMenu.isEmpty ? Container() : state.listMenu[state.indexMenu].screen,
        );
      }),
    );
  }
}
