import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_scanner/src/models/ScanModel.dart';

class MapPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
  final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: this.createFlutterMap(scan),
    );
  }

  Widget createFlutterMap(ScanModel scan){
    return FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 10
      ),
      layers: [
        this.createMap()
      ],
    );
  }

  createMap(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiYXJub2xkMDI1IiwiYSI6ImNrNTFmczM4bzByMjYza21pZjRva2tsZm4ifQ.J3dBISiGYq9jWJIQ-dEHPg',
        'id': 'mapbox.streets',
      }
    );
  }
}