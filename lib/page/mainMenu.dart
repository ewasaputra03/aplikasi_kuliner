import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:program/data/listKuliner.dart';
import 'package:program/page/about.dart';
import 'package:program/page/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  void saveId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final listnya = json.encode(AppConstant.list);
    final list = prefs.getString('list');
    if (list == null) {
      prefs.setString('list', listnya);
      print('tidak ada prefs');
    } else {
      // prefs.setString('list', listnya);
      print('ada prefs listnya');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveId();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.red[300],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    'assets/img.jpg',
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
                transform: Matrix4.translationValues(0, 590, 1),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 90.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      'Kuliner Bandar lampung',
                      style:
                          GoogleFonts.nunito(fontSize: 32, color: Colors.black),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          Get.to(HomePage());
                        },
                        child: Text(
                          'Menu Utama',
                          style: GoogleFonts.nunito(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: size.width / 1.7,
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          Get.to(MenuAbout());
                        },
                        child: Text(
                          'Menu About',
                          style: GoogleFonts.nunito(
                              fontSize: 18, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
