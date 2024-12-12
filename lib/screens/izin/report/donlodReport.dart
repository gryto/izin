import 'dart:io';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../bloc/izin/izin_cubit.dart';
import '../../../bloc/izin/izin_state.dart';

class DownloadReportPage extends StatefulWidget {
  final String path;
  final String name;

  const DownloadReportPage({Key? key, required this.path, required this.name})
      : super(key: key);

  @override
  State<DownloadReportPage> createState() => _DownloadReportPageState();
}

class _DownloadReportPageState extends State<DownloadReportPage> {
  // Check and request storage permission
  Future<bool> checkStoragePermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  // Download PDF function
  Future downloadPdf(BuildContext context, String fileName, String fileUrl) async {
    final output = await getDownloadPath(context);
    if (output == null) {
      _onAlertButtonPressed(context, false, "Folder download tidak ditemukan");
      return;
    }

    final savePath = '$output/$fileName';
    download2(context, fileUrl, savePath);
  }

  // Download file using Dio
  Future download2(BuildContext context, String fileUrl, String savePath) async {
    try {
      Response response = await Dio().get(
        fileUrl,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );

      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      _onAlertButtonPressed(context, true, "File PDF berhasil di download");
    } catch (e) {
      _onAlertButtonPressed(context, false, e.toString());
    }
  }

  // Show download progress
  void showDownloadProgress(int received, int total) {
    if (total != -1) {
      (received / total * 100).toStringAsFixed(0);
    }
  }

  // Get download path for Android/iOS
  Future<String?> getDownloadPath(BuildContext context) async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      _onAlertButtonPressed(context, false, "Folder download tidak ditemukan");
    }
    return directory?.path;
  }

  // Show alert on success/failure
  _onAlertButtonPressed(BuildContext context, bool status, String message) {
    Alert(
      context: context,
      type: status ? AlertType.success : AlertType.error,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          color: const Color.fromARGB(255, 12, 159, 111),
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        elevation: 0,
        // actions: [
        //   GestureDetector(
        //     onTap: () async {
        //       // Check for storage permission before downloading
        //       if (await checkStoragePermission()) {
        //         await downloadPdf(context, widget.name, widget.path);
        //       } else {
        //         _onAlertButtonPressed(context, false, "Izin penyimpanan diperlukan untuk melanjutkan.");
        //       }
        //     },
        //     child: const Padding(
        //       padding: EdgeInsets.only(right: 15),
        //       child: Icon(Icons.download),
        //     ),
        //   ),
        // ],
      ),
      body: BlocConsumer<IzinCubit, IzinState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SfPdfViewer.network(
            widget.path,
            onDocumentLoadFailed: (details) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal memuat PDF: ${details.error}')),
              );
            },
          );
        },
      ),
    );
  }
}

