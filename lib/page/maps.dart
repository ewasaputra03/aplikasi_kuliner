import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:program/data/listKuliner.dart';
import 'package:program/page/detailPage.dart';
import 'package:program/page/mainMenu.dart';
import 'package:program/page/tambah_list.dart';
import 'package:url_launcher/url_launcher.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Completer<GoogleMapController> _controller = Completer();

  bool visible = false;

  final Set<Marker> _markerss = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapToolbarEnabled: true,
        buildingsEnabled: true,
        mapType: MapType.normal,
        markers: _markerss,
        initialCameraPosition: CameraPosition(
          target: LatLng(-5.3828361, 105.2524245),
          zoom: 14.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (latLng) {
          print('${latLng.latitude}, ${latLng.longitude}');
          _onAddMarkerButtonPressed(latLng);
        },
      ),
    );
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markerss.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(latlang.toString()),
        position: latlang,
        infoWindow: InfoWindow(
            title: 'Pilih Posisi',
            onTap: () {
              Get.to(TambahList(
                  lat: latlang.latitude.toString(),
                  lng: latlang.longitude.toString()));
            }),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
}
