import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

import '../../core/utils/app_assets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  String _mapStyle = '';
  LocationData? _currentLocation;
  final Location _locationService = Location();

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  BitmapDescriptor? _userIcon;
  BitmapDescriptor? _storeIcon;

  final LatLng storeLatLng = const LatLng(15.3492, 44.2066);

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _setCustomMarkerIcons();
    _getUserLocation();
  }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_styles/map_style.json');
    if (_controller != null) {
      _controller!.setMapStyle(_mapStyle);
    }
    setState(() {});
  }

  void _setCustomMarkerIcons() async {
    _storeIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(40, 40)),
      ImageAssets.image1,
    );

    _userIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

    setState(() {});
  }

  Future<void> _getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationService.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationService.requestService();
      if (!_serviceEnabled) return;
    }

    _permissionGranted = await _locationService.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationService.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    final locationData = await _locationService.getLocation();
    setState(() {
      _currentLocation = locationData;
    });

    _setMarkersAndPolyline();
  }

  void _setMarkersAndPolyline() {
    if (_currentLocation == null) return;

    final userLatLng = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);

    _markers = {
      Marker(
        markerId: const MarkerId('user_location'),
        position: userLatLng,
        icon: _userIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'موقعك'),
      ),
      Marker(
        markerId: const MarkerId('store_location'),
        position: storeLatLng,
        icon: _storeIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Haraz Cafe'),
      ),
    };

    _polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: [userLatLng, storeLatLng],
        color: Colors.brown,
        width: 5,
      )
    };

    _moveCameraToBounds(userLatLng, storeLatLng);

    setState(() {});
  }

  Future<void> _moveCameraToBounds(LatLng point1, LatLng point2) async {
    if (_controller == null) return;

    LatLngBounds bounds;
    if (point1.latitude > point2.latitude && point1.longitude > point2.longitude) {
      bounds = LatLngBounds(southwest: point2, northeast: point1);
    } else if (point1.longitude > point2.longitude) {
      bounds = LatLngBounds(
        southwest: LatLng(point1.latitude, point2.longitude),
        northeast: LatLng(point2.latitude, point1.longitude),
      );
    } else if (point1.latitude > point2.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(point2.latitude, point1.longitude),
        northeast: LatLng(point1.latitude, point2.longitude),
      );
    } else {
      bounds = LatLngBounds(southwest: point1, northeast: point2);
    }

    final cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 100);
    _controller!.animateCamera(cameraUpdate);
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    if (_mapStyle.isNotEmpty) {
      _controller!.setMapStyle(_mapStyle);
    }
    if (_currentLocation != null) {
      _setMarkersAndPolyline();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          zoom: 14,
        ),
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}