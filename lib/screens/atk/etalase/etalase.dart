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
                              progress: etalase.jumlah ?? "-",
                              buttonText: 'Add to Chart',
                              onClickButton: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Add to Cart",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.close), // Ikon silang
                                          onPressed: () => Navigator.pop(
                                              context), // Tutup dialog
                                        ),
                                      ],
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        // mainAxisSize: MainAxisSize
                                        //     .min, // Menyesuaikan ukuran dialog
                                        children: [
                                          const Divider(
                                              thickness: 2, color: Colors.black12),
                                          const SizedBox(height: 5),
                                          ListTile(
                                            title: Column(
                                              children: [
                                                Text(
                                                  etalase.namaBarang ?? "-",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                 Divider(
                                                    thickness: 2,
                                                    color: Colors.grey[300],),
                                                const SizedBox(height: 2),
                                              ],
                                            ),
                                            subtitle: Column(
                                              children: [
                                                const SizedBox(height: 15),
                                                TextFormField(
                                                  enabled: true,
                                                  readOnly: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller:
                                                      TextEditingController(
                                                          text:
                                                              etalase.jumlah ??
                                                                  "-"),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[300],
                                                    labelText: "Stok tersedia",
                                                    labelStyle: const TextStyle(
                                                      fontSize:
                                                          16, // Ukuran font label lebih besar
                                                    ),
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .always, // Label selalu di atas
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Melengkung
                                                      borderSide: BorderSide
                                                          .none, // Hilangkan outline
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Row(
                                                  children: [
                                                    // Input Jumlah
                                                    SizedBox(
                                                      width: 100, // Lebar input
                                                      child: TextFormField(
                                                        controller: state
                                                            .jumlahController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.center,
                                                        decoration:
                                                            InputDecoration(
                                                          filled: true,
                                                          labelText: "Jumlah",
                                                          fillColor: Colors
                                                                  .grey[
                                                              100], // Warna abu muda lebih muda lagi
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                      .grey[
                                                                  700]), // Label warna lebih gelap

                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8), // Melengkung
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                      .grey[
                                                                  300]!, // Border abu tua
                                                              width:
                                                                  1, // Lebar border
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                        width:
                                                            5), // Jarak kecil

                                                    // Tombol Plus (Biru)
                                                    IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<AtkCubit>()
                                                            .tambahJumlah();
                                                      },
                                                      icon: const Icon(
                                                          Icons.add,
                                                          color: Colors.white),
                                                      style:
                                                          IconButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .blue, // Warna biru
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8), // Melengkung
                                                        ),
                                                      ),
                                                    ),
                                                    // Tombol Minus (Merah)
                                                    IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<AtkCubit>()
                                                            .kurangJumlah();
                                                      },
                                                      icon: const Icon(
                                                          Icons.remove,
                                                          color: Colors.white),
                                                      style:
                                                          IconButton.styleFrom(
                                                        backgroundColor: Colors
                                                            .red, // Warna merah
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8), // Melengkung
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 67, 128, 252),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
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
