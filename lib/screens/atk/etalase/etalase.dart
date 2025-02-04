import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../bloc/atk/atk_cubit.dart';
import '../../../bloc/atk/atk_state.dart';
import '../../components/etalase_card.dart';

class EtalasePage extends StatefulWidget {
  const EtalasePage({super.key});

  @override
  State<EtalasePage> createState() => _EtalasePageState();
}

class _EtalasePageState extends State<EtalasePage> {
  late AtkCubit atkCubit;

  @override
  void initState() {
    super.initState();
    atkCubit = context.read<AtkCubit>();
    atkCubit.initDataEtalase(context);
    print("stlh initdata");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Icon(Icons.shopping_cart),),
      body: BlocConsumer<AtkCubit, AtkState>(
        listener: (context, state) {
          print("State changed: $state");
          if (state.isUpdateSuccess) {
            AwesomeDialog(
              dismissOnTouchOutside: false,
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.topSlide,
              title: 'Success',
              desc: 'Data Berhasil Diupdate !!!',
              btnOkOnPress: () async {
                // atkCubit.refreshSubmissionData(context);
              },
            ).show();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              // Search Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                color: Colors.white,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Cari barang...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<AtkCubit>().filterEtalase(value);
                  },
                ),
              ),

              // List Barang
              Expanded(
                child: SingleChildScrollView(
                  child: state.filteredEtalase.isNotEmpty
                      ? MasonryGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.filteredEtalase.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          itemBuilder: (context, index) {
                            var etalase = state.filteredEtalase[index];
                            return EtalaseCard(
                              image: NetworkImage(etalase!.url ?? "-"),
                              icon: Icons.abc,
                              title: etalase.namaBarang ?? "-",
                              color: Colors.blueAccent,
                              colorbg: Colors.white,
                              colorTitle: Colors.black,
                              onClick: () {},
                              progress: etalase.jumlah ?? "-",
                            );
                          },
                        )
                      : const Center(
                          child: Text("Tidak ada barang yang ditemukan"),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
