import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //create controller maps
  Completer<GoogleMapController> mapController = Completer();
  //start location I select my Uni
  //40.9719226,29.1477118,16.25z
  var startPosition =
      const CameraPosition(target: LatLng(40.9719226, 29.1477118), zoom: 10);
  //create marker List
  List<Marker> marker = <Marker>[];
  //go to my home
  Future<void> goToLocation() async {
    GoogleMapController controller = await mapController.future;
    //my home location
    //40.9179718,29.134586,19.2z
    var goTo =
        const CameraPosition(target: LatLng(40.9179718, 29.134586), zoom: 19);
    //move w/controller
    controller.animateCamera(CameraUpdate.newCameraPosition(goTo));
    //set Marker
    var setMarker = const Marker(
      markerId: MarkerId("id"),
      position: LatLng(40.9179718, 29.134586),
      infoWindow: InfoWindow(title: "Home", snippet: "Cumali's Home"),
    );
    setState(() {
      marker.add(setMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.location_on_outlined,
          color: Colors.white,
        ),
        title: const Text(
          "Maps Usage",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[400],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: startPosition,
                mapType: MapType.normal,
                markers: Set<Marker>.of(marker),
                onMapCreated: (GoogleMapController constroller) {
                  mapController.complete(constroller);
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[400],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  onPressed: () {
                    goToLocation();
                  },
                  child: const Text(
                    "Go To Location",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
