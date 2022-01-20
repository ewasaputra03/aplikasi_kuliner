import 'package:flutter/material.dart';
import 'package:program/data/listKuliner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahList extends StatefulWidget {
  const TambahList({Key? key}) : super(key: key);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = AppConstant.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah data warung'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            textField('Nama Warung', controllerNama, 1),
            textField('Deskripsi', controllerDeskripsi, 5),
            textField('Longitude', controllerLong, 1),
            textField('Latitude', controllerLat, 1),
            SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(18)),
              child: MaterialButton(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  _list!.add({
                    "title": controllerNama.text,
                    'des': controllerDeskripsi.text,
                    "id": id,
                    "lat": int.parse(controllerLong.text),
                    "lon": int.parse(controllerLat.text)
                  });
                  setState(() {
                    prefs.setInt('id', id++);
                  });
                },
                child: Text('Tambah Warung'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textField(String judul, TextEditingController controller, int line) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(judul),
          SizedBox(
            height: 16,
          ),
          TextField(
            controller: controller,
            maxLines: line,
          )
        ],
      ),
    );
  }

  void saveId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final idnya = prefs.getInt('id');
    if (idnya == null) {
      prefs.setInt('id', id);
      print('tidak ada prefs');
    } else {
      setState(() {
        id = idnya;
        print('id dari prefs');
      });
    }
  }
}
