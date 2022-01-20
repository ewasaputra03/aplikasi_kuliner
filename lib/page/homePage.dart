import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:program/data/listKuliner.dart';
import 'package:program/page/detailPage.dart';
import 'package:program/page/mainMenu.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];
  bool visible = false;

  Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
    return Marker(
        markerId: MarkerId(AppConstant.list[index]['id']),
        position: LatLng(
          AppConstant.list[index]['lat'],
          AppConstant.list[index]['lon'],
        ),
        onTap: () {
          print('tap aja');
        },
        infoWindow: InfoWindow(
            onTap: () {
              final warung = AppConstant.list[index]["title"];
              final deskripsi = AppConstant.list[index]["des"];
              final lat = AppConstant.list[index]['lat'];
              final lon = AppConstant.list[index]['lon'];
              Get.to(DetailPage(
                  warung: warung, deskripsi: deskripsi, lat: lat, lon: lon));
            },
            title: AppConstant.list[index]["title"]));
  });

  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer(context),
      appBar: AppBar(
        title: Text('Menu'),
        backgroundColor: Colors.red[300],
      ),
      body: GoogleMap(
        mapToolbarEnabled: true,
        buildingsEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(-5.3828361, 105.2524245),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red[300],
        onPressed: () {
          print('button ditekan');
        },
        label: Text('Tambah Info!'),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget sideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Street Food \n Bandar Lampung',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red[300],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Get.off(MainMenu())},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Keluar'),
            onTap: () => {SystemNavigator.pop()},
          ),
        ],
      ),
    );
  }
}
