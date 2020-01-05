import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_scanner/src/bloc/ScansBloc.dart';
import 'package:qr_scanner/src/models/ScanModel.dart';

import 'package:qr_scanner/src/pages/AddressesPage.dart';
import 'package:qr_scanner/src/pages/MapsPage.dart';
import 'package:qr_scanner/src/utils/utils.dart' as utils;

import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.deleteAllScans,
          )
        ],
      ),
      body: callPage(this.currentIndex),
      bottomNavigationBar: this.getBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: ()=> this.scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  scanQR(BuildContext context) async {
    // geo: 40.724233047051705,-74.00731459101564
    String futureString;
    try{
      futureString = await new QRCodeReader().scan();
    }catch(err){
      futureString = err.toString();
      print('error: $futureString');
    }
    if (futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.addScan(scan);
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScan(context, scan);
        });
      } else {
        utils.openScan(context, scan);
      }
    }
  }

  Widget callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return AddressesPage();
      default:
        return MapsPage();
    }
  }

  Widget getBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: this.currentIndex,
      onTap: (index) {
        setState(() {
          this.currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }
}
