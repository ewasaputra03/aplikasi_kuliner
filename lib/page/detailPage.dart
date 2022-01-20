import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final String warung, deskripsi;
  final double lat, lon;
  const DetailPage(
      {Key? key,
      required this.warung,
      required this.deskripsi,
      required this.lat,
      required this.lon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(warung),
        backgroundColor: Colors.red[300],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                warung,
                style: GoogleFonts.nunito(fontSize: 24, color: Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                deskripsi,
                style: GoogleFonts.nunito(fontSize: 24, color: Colors.black),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () async {
                    final url =
                        'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not open the map.';
                    }
                  },
                  child: Text('Rute', style: GoogleFonts.nunito(fontSize: 24, color: Colors.white)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textColor: Colors.black,
                  color: Colors.red[300],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
