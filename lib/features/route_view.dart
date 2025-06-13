import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;

import '../core/utils/app_assets.dart';
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
    // صورة الاستور من ملف الأصول (مثلاً صورة مخصصة)
    _storeIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(40, 40)),
      ImageAssets.image1,
    );

    // أيقونة المستخدم ماركر افتراضي أزرق
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



// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:math' as math;
// import 'package:location/location.dart';
//
// import '../core/utils/app_colors.dart';
// import '../data/location_service.dart';
// import '../data/routes_api.dart';
// import '../data/routes_model/location_info.dart';
// import '../data/routes_model/routes_model.dart';
//
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   late final CameraPosition cameraPosition;
//   late final LocationService _locationService;
//   late GoogleMapController _mapController;
//
//   late final BitmapDescriptor _driverMarker;
//   late final BitmapDescriptor _userMarker;
//   late final BitmapDescriptor _storeMarker;
//
//   late final LocationData driverLocation;
//   late final RoutesApi routesApi;
//
//   final Set<Polyline> _polylines = {};
//   final Set<Marker> _markers = {};
//
//   // موقع حراز كافيه في صنعاء، اليمن
//   final LatLng _storeLocation = const LatLng(15.353889, 44.207500);
//
//   @override
//   void initState() {
//     super.initState();
//     _initCameraPosition();
//     _locationService = LocationService();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       polylines: _polylines,
//       markers: _markers,
//       onMapCreated: (controller) async {
//         _mapController = controller;
//         routesApi = RoutesApi();
//
//         await _initMapStyle();
//         await _loadMarkerIcons();
//
//         await _moveToUserLocation();
//         await _drawRoute();
//       },
//       initialCameraPosition: cameraPosition,
//       myLocationEnabled: true,
//       myLocationButtonEnabled: true,
//     );
//   }
//
//   void _initCameraPosition() {
//     // تركز الكاميرا على حدود اليمن مبدئيًا مع تقريب متوسط
//     cameraPosition = const CameraPosition(
//       target: LatLng(15.5, 44.0), // وسط اليمن
//       zoom: 6,
//     );
//   }
//
//   Future<void> _moveToUserLocation() async {
//     driverLocation = await _locationService.getUserLocation();
//     CameraPosition newPosition = CameraPosition(
//       target: LatLng(driverLocation.latitude!, driverLocation.longitude!),
//       zoom: 16,
//     );
//
//     // تحريك الكاميرا إلى موقع المستخدم
//     _mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));
//
//     // إضافة علامة موقع المستخدم
//     _markers.add(Marker(
//       markerId: const MarkerId('user'),
//       position: LatLng(driverLocation.latitude!, driverLocation.longitude!),
//       icon: _userMarker,
//       infoWindow: const InfoWindow(title: 'موقعك'),
//     ));
//
//     // إضافة علامة حراز كافيه
//     _markers.add(Marker(
//       markerId: const MarkerId('store'),
//       position: _storeLocation,
//       icon: _storeMarker,
//       infoWindow: const InfoWindow(title: 'Haraz Cafe'),
//     ));
//
//     setState(() {});
//   }
//
//   Future<void> _initMapStyle() async {
//     final style = await DefaultAssetBundle.of(context)
//         .loadString('assets/map_styles/map_style.json');
//     _mapController.setMapStyle(style);
//   }
//
//   Future<void> _loadMarkerIcons() async {
//     _userMarker = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       'assets/images/user_location.png',
//     );
//     _storeMarker = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       'assets/images/store_location.png',
//     );
//   }
//
//   Future<void> _drawRoute() async {
//     LatLngModel originLatLng = LatLngModel(
//       latitude: driverLocation.latitude!,
//       longitude: driverLocation.longitude!,
//     );
//     LatLngModel destinationLatLng = LatLngModel(
//       latitude: _storeLocation.latitude,
//       longitude: _storeLocation.longitude,
//     );
//     LocationInfo origin = LocationInfo(latLng: originLatLng);
//     LocationInfo destination = LocationInfo(latLng: destinationLatLng);
//     RoutesModel routesModel = await routesApi.fetchRoutes(
//       origin: origin,
//       destination: destination,
//     );
//
//     List<LatLng> points = _decodePolyline(routesModel);
//     _addPolyline(points);
//   }
//
//   List<LatLng> _decodePolyline(RoutesModel routesModel) {
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<PointLatLng> result = polylinePoints.decodePolyline(
//       routesModel.routes!.first.polyline!.encodedPolyline!,
//     );
//     log("Polyline points count: ${result.length}");
//     return result.map((e) => LatLng(e.latitude, e.longitude)).toList();
//   }
//
//   void _addPolyline(List<LatLng> points) {
//     final polyline = Polyline(
//       polylineId: const PolylineId('route'),
//       color: Colors.brown,
//       width: 5,
//       points: points,
//     );
//     _polylines.add(polyline);
//
//     LatLngBounds bounds = _calculateBounds(points);
//     _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//
//     setState(() {});
//   }
//
//   LatLngBounds _calculateBounds(List<LatLng> points) {
//     double southWestLat = points[0].latitude;
//     double southWestLng = points[0].longitude;
//     double northEastLat = points[0].latitude;
//     double northEastLng = points[0].longitude;
//
//     for (var point in points) {
//       southWestLat = math.min(southWestLat, point.latitude);
//       southWestLng = math.min(southWestLng, point.longitude);
//       northEastLat = math.max(northEastLat, point.latitude);
//       northEastLng = math.max(northEastLng, point.longitude);
//     }
//
//     return LatLngBounds(
//       southwest: LatLng(southWestLat, southWestLng),
//       northeast: LatLng(northEastLat, northEastLng),
//     );
//   }
// }
