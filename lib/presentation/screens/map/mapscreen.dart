

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:weather/core/appcolors.dart';
import 'package:weather/core/routeArguments.dart';

class MapScreen extends StatefulWidget {
  static const mapRoute = "mapscreen";
  final data = {};
  final MapArguments args;
  MapScreen(this.args, {super.key});

  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
   marker();
    super.initState();
  }


 marker(){
  Timer(const Duration(seconds: 3),(){
  
    setState(() {
         _markers.addLabelMarker(LabelMarker(
      label: 'temp:${widget.args.temp} humidity:${widget.args.humidity}',
      backgroundColor: AppColors.cardColor,
      position: LatLng(widget.args.lat, widget.args.long),
      markerId: const MarkerId('3'), ));
   
    });
  });
 }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Location'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
        marker();
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.args.lat, widget.args.long),
          zoom: 15.0,
        ),
        markers:_markers
      ),
    );
  }
}
