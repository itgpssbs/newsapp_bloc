import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoadMapScreen extends StatefulWidget{
  const LoadMapScreen({Key ? key}): super(key : key);
  static const routeName = '/map_screen';

  @override
  State<LoadMapScreen> createState()=> _LoadMapScreenState();
}

class _LoadMapScreenState extends State<LoadMapScreen>{
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  final List<PositionItem> arrPositionItems = <PositionItem>[];
  late GoogleMapController controller;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Load Map From user location'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: InkWell(
          onTap:()async{
            await getCurrentPosition();
          }     ,
          child:Column(
            children:[
              Text("Load Map"),
              Container(
                width: 300,
                height: 500,
                child: GoogleMap(
                  // initialCameraPosition: userInitialPosition,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(-7.219068,112.7308542),
                    zoom: 11.0
                  ),
                  onMapCreated: onMapCreated,
                )
              )
            ],
          ),
        ),
      )
    );
  }

  Future<void> getCurrentPosition() async{
    final hasPermission = await handlePermission();
    if (!hasPermission){
      return;
    }
    final position = await geolocatorPlatform.getCurrentPosition();
    updatePositionList(PositionItemType.log, position.toString());
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              position.latitude,
              position.longitude
          ),
        )
      )
    );
  }

  Future<bool> handlePermission() async{
    bool locationServiceEnabled;
    LocationPermission locationPermission;
    locationServiceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!locationServiceEnabled){
      updatePositionList(PositionItemType.log, "Location Service di disabled");
      return false;
    }
    locationPermission = await geolocatorPlatform.checkPermission();
    if (locationPermission == LocationPermission.denied){
      locationPermission = await geolocatorPlatform.requestPermission();
      if (locationPermission == LocationPermission.denied){
        updatePositionList(PositionItemType.log, "Permission Denied");
        return false;
      }
    }
    if (locationPermission == LocationPermission.deniedForever){
      updatePositionList(PositionItemType.log, "Permission Denied");
      return false;
    }
    updatePositionList(PositionItemType.log, "Permission granted");
    return true;
  }
  void updatePositionList(PositionItemType type, String displayValue){
    arrPositionItems.add(PositionItem(type, displayValue));
    setState((){});
  }

  void onMapCreated(GoogleMapController gmapcontroller) {
    setState(() {
        controller = gmapcontroller;
    });
  }
}

enum PositionItemType{
  log,
  position
}

class PositionItem{
  PositionItem(this.type, this.displayValue);
  final PositionItemType type;
  final String displayValue;
}