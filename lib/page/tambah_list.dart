import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:program/data/listKuliner.dart';
import 'package:program/page/homePage.dart';
import 'package:program/page/maps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahList extends StatefulWidget {
  final String lat, lng;
  const TambahList({Key? key, required this.lat, required this.lng})
      : super(key: key);

  @override
  _TambahListState createState() => _TambahListState();
}

class _TambahListState extends State<TambahList> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerLong = TextEditingController();
  TextEditingController controllerLat = TextEditingController();

  List<Map<String, dynamic>>? _list;
  int id = 17;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String text = '0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerLong.text = widget.lng;
    controllerLat.text = widget.lat;
    saveId();
    _list = AppConstant.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Tambah data warung'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                textField('Longitude', controllerLong, 1, true),
                SizedBox(
                  height: 8,
                ),
                textField('Latitude', controllerLat, 1, true),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(18)),
                    child: MaterialButton(
                      onPressed: () async {
                        Get.to(Maps());
                      },
                      child: Text(
                        'Pilih Posisi',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                textField('Nama Warung', controllerNama, 1, false),
                SizedBox(
                  height: 8,
                ),
                textField('Deskripsi', controllerDeskripsi, 5, false),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 64,
                ),
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(18)),
                    child: MaterialButton(
                      onPressed: controllerLong.text == '0'
                          ? () {
                              Get.snackbar(
                                  'Gagal', 'Harap lengkapi data warung!',
                                  backgroundColor: Colors.blueAccent,
                                  colorText: Colors.white);
                            }
                          : () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              final list = prefs.getString('list');
                              final listnya = json.decode(list!);
                              try {
                                // tambahList(
                                //     controllerNama.text,
                                //     controllerDeskripsi.text,
                                //     id,
                                //     controllerLong.text,
                                //     controllerLat.text);
                                listnya.add({
                                  "title": controllerNama.text,
                                  'des': controllerDeskripsi.text,
                                  "id": id.toString(),
                                  "lat": double.parse(controllerLat.text),
                                  "lon": double.parse(controllerLong.text)
                                });
                                setState(() {
                                  final listFinal = json.encode(listnya);
                                  prefs.setString('list', listFinal);
                                  prefs.setInt('id', id + 1);
                                  print(id);
                                  Get.to(HomePage());
                                });
                              } catch (e) {
                                print('tidak dapat simpan list $e');
                              }
                            },
                      child: Text(
                        'Tambah Warung',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Text(text, style: TextStyle(fontSize: 24),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> tambahList(
    String controllerName,
    String controllerDeskripsi,
    int id,
    String controllerLong,
    String controllerLat,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final list = prefs.getString('list');
    final listnya = json.decode(list!);

    listnya.add({
      "title": controllerName,
      'des': controllerDeskripsi,
      "id": id,
      "lat": double.parse(controllerLong),
      "lon": double.parse(controllerLat)
    });
  }

  Widget textField(String judul, TextEditingController controller, int line, bool ignore) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 8,
          ),
          IgnorePointer(
            ignoring: ignore,
            child: TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              controller: controller,
              maxLines: line,
            ),
          )
        ],
      ),
    );
  }

  void saveId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final idnya = prefs.getInt('id');
    final list = prefs.getString('list');
    final finalini = json.decode(list!);
    print('id nya ini ' + idnya.toString() + 'ini list nya \n' + finalini.toString());
    setState(() {
      text = list;
    });
    if (idnya == null) {
      prefs.setInt('id', id);
      print('tidak ada prefs');
    } else {
      setState(() {
        // prefs.setInt('id', id);
        id = idnya;
        print('id dari prefs ' + idnya.toString());
      });
    }
  }
}
