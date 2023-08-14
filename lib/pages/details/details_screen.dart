import 'dart:io';
import 'package:book_app/core/book_api.dart';
import 'package:book_app/data/model/BookModel.dart';
import 'package:book_app/pages/read/read_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

enum Status { initial, loading, fail, success }

class _DetailScreenState extends State<DetailScreen> {
  final api = BookApi();
  var details = BookModel.empty();
  var status = Status.initial;
  var path = "";
  var hasPdf = false;
  var progress = 0;

  @override
  void initState() {
    loadData().then((value) => checkPdf());
    super.initState();
  }

  Future<void> loadData() async {
    status = Status.loading;
    setState(() {});
    try {
      details = await api.getDetails(widget.id);
      status = Status.success;
    } catch (e) {
      status = Status.fail;
    }
    setState(() {});
  }

  Future<void> checkPdf() async {
    final dir = await getApplicationDocumentsDirectory();
    path = "${dir.path}/${details.name}";
    final file = File(path);
    hasPdf = await file.exists();
    setState(() {});
  }

  Future<void> onDownload() async {
    if (hasPdf) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReadScreen(path: path, name:details.name,)),
      );
      return;
    }
    await Dio().download(
      details.pdf,
      path,
      onReceiveProgress: (count, total) {
        progress = 100 * count ~/ total;
        setState(() {});
      },
    );
    hasPdf = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          details.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Builder(builder: (context) {
          if (status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (status == Status.fail) {
            return const Center(
              child: Text("Xatolik", style: TextStyle(fontSize: 32)),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: details.image,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 6),
                Text(
                  details.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details.author,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    textAlign: TextAlign.justify,
                    details.authorDesc,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onDownload,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      alignment: Alignment.center,
                      width: 358,
                      height: 55,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 12),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD45454),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Builder(builder: (context) {
                        if (hasPdf) {
                          return const Text(
                            "Ochish",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          );
                        }
                        if (progress != 0) {
                          return Text(
                            "Yuklanmoqda [$progress%]",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          );
                        }
                        return const Text(
                          "Yuklash",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
