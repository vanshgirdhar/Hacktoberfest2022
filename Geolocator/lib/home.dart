// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getmygps/login.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  late Position _currentPosition;
  String currentAddress = "";

  void getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        currentAddress =
            "${place.thoroughfare},${place.subThoroughfare},${place.name}, ${place.subLocality}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Icon(Icons.location_on_outlined,
                  size: 100, color: Color(0XFF6C63FF)),
              Text(currentAddress,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              GestureDetector(
                  onTap: () {
                    getCurrentLocation();
                  },
                  child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                          child: Text('Get Location',
                              style: TextStyle(color: Colors.white))),
                      decoration: BoxDecoration(
                          color: Color(0XFF6C63FF),
                          borderRadius: BorderRadius.circular(8)))),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Container(
                      height: 40,
                      width: 100,
                      child: Center(
                          child: Text('Logout',
                              style: TextStyle(color: Colors.white))),
                      decoration: BoxDecoration(
                          color: Color(0XFF6C63FF),
                          borderRadius: BorderRadius.circular(8))))
            ])));
  }
}
