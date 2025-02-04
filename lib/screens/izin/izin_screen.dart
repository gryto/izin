import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/izin/izin_cubit.dart';
import '../../bloc/izin/izin_state.dart';
import '../../utils/constants/colors.dart';

class IzinScreen extends StatefulWidget {
  const IzinScreen({super.key});

  @override
  State<IzinScreen> createState() => _IzinScreenState();
}

class _IzinScreenState extends State<IzinScreen> {
  late IzinCubit izinCubit;
  @override
  void initState() {
    super.initState();
    // Panggil initData saat widget pertama kali diinisialisasi
    // profileCubit = BlocProvider.of<ProfileCubit>(context); // untuk
    izinCubit = context.read<IzinCubit>();
    izinCubit.initMenu();
    izinCubit.navigateTo('Dashboard', 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<IzinCubit, IzinState>(builder: (context, state) {
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
                            .read<IzinCubit>()
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
