import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';
import '../../../utils/helper/helper.dart';

class DownloadDioPage extends StatefulWidget {
  final String path;
  final String name;

  const DownloadDioPage({Key? key, required this.path, required this.name})
      : super(key: key);

  @override
  State<DownloadDioPage> createState() => _DownloadDioPageState();
}

class _DownloadDioPageState extends State<DownloadDioPage> {
  String? token;

  // Ambil token yang disimpan
  Future<void> getToken() async {
    token = await Helper().getToken(); // Ambil token yang disimpan
    setState(() {}); // Memperbarui UI setelah token berhasil diambil
    print("Token fetched: $token");
  }

  // Ambil PDF dengan token dan tampilkan
  // Future<Uint8List?> fetchPdf(String url, String token) async {
  //   print("Fetching PDF with URL: $url and Token: $token");
  //   try {
  //     final dio = Dio();
  //     final response = await dio.get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token', // Sertakan token untuk autentikasi
  //         },
  //         responseType: ResponseType.bytes,
  //       ),
  //     );
  //     print("PDF fetched successfully");
  //     print(response);
  //     return response.data; // Mengembalikan data PDF dalam bentuk bytes
  //   } catch (e) {
  //     print('Failed to load PDF: $e');
  //   }
  //   return null;
  // }

  // Future<Uint8List?> fetchPdf(String url, String token) async {
  //   try {
  //     final dio = Dio();
  //     final response = await dio.get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Authorization':
  //               'Bearer $token', // Sertakan token untuk autentikasi
  //                'Accept': 'application/pdf', // Tambahkan ini
  //         },
  //         responseType: ResponseType.bytes,
  //       ),
  //     );

  //     // Pastikan server mengirimkan content-type: application/pdf
  //     if (response.statusCode == 200 &&
  //         response.headers.value('content-type')?.contains('application/pdf') ==
  //             true) {
  //       return response.data;
  //     } else {
  //       // Tangani error jika bukan PDF atau ada masalah lain
  //       print('Failed to fetch PDF, status code: ${response.statusCode}');
  //       print('Content-Type: ${response.headers.value('content-type')}');
  //     }
  //   } catch (e) {
  //     print('Failed to load PDF: $e');
  //   }
  //   return null;
  // }

  Future<Uint8List?> fetchPdf(String url, String token) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/pdf',
          },
          responseType: ResponseType.bytes,
        ),
      );

      print('Status Code: ${response.statusCode}');
      print('Content-Type: ${response.headers.value('content-type')}');
      if (response.statusCode == 200 &&
          response.headers.value('content-type')?.contains('application/pdf') ==
              true) {
        print('PDF fetched successfully');
        return response.data;
      } else {
        print('Unexpected response: ${String.fromCharCodes(response.data)}');
        return null;
      }
    } catch (e) {
      print('Failed to load PDF: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getToken(); // Ambil token saat halaman dimuat
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan indikator loading jika token masih null
    if (token == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: BlocConsumer<IzinCubit, IzinState>(
          listener: (context, state) {},
          builder: (context, state) {
            return FutureBuilder<Uint8List?>(
              future: fetchPdf(widget.path, token!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return SfPdfViewer.memory(
                    snapshot.data!, // Menampilkan data PDF dari bytes
                    onDocumentLoadFailed: (details) {
                      print("Failed to load PDF: ${details.error}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to load PDF')),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No PDF found'));
                }
              },
            );
          }),
    );
  }
}
