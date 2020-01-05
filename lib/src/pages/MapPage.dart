import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_scanner/src/models/ScanModel.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController map = new MapController();

  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {
  final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: this.createFlutterMap(scan),
      floatingActionButton: this.createFloatingButton(context),
    );
  }

  Widget createFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        this.createMap(),
        this.createBookMark(scan)
      ],
    );
  }

  createMap(){
    return TileLayerOptions(//TODO:: archivo de configuración.
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiYXJub2xkMDI1IiwiYSI6ImNrNTFmczM4bzByMjYza21pZjRva2tsZm4ifQ.J3dBISiGYq9jWJIQ-dEHPg',
        'id': 'mapbox.$mapType',
      }
    );
  }

  createBookMark(ScanModel scan){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );
  }

  Widget createFloatingButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){//streets, dark, light, outdoors, satellite
        this.changeMapType();
        setState(() {
          
        });
      },
    );
    
  }
  changeMapType(){
    if(mapType == 'streets') mapType = 'dark';
    else if(mapType == 'dark') mapType = 'light';
    else if(mapType == 'light') mapType = 'outdoors';
    else if(mapType == 'outdoors') mapType = 'satellite';
    else mapType = 'dark';
  }
}