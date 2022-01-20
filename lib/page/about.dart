import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuAbout extends StatelessWidget {
  const MenuAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text(
          'About',
          style: GoogleFonts.nunito(fontSize: 18, color: Colors.red[300]),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.red[300],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sistem Informasi Warung Kuliner di Kota Bandar Lampung \n coba lagi',
                style: GoogleFonts.nunito(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Chris Arie Sadewo',
                style: GoogleFonts.nunito(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 40),
              Text(
                'ver 1.0',
                style: GoogleFonts.nunito(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
