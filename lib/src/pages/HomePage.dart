import 'package:flutter/material.dart';
import 'package:qr_scanner/src/pages/AddressesPage.dart';
import 'package:qr_scanner/src/pages/MapsPage.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){},
          )
        ],
      ),
      body: callPage(this.currentIndex),
      bottomNavigationBar: this.getBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => this.scanQR(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  scanQR() async {
    // geo: 40.724233047051705,-74.00731459101564
    String futureString = '';
    // try{
    //   futureString = await new QRCodeReader().scan();
    // }catch(err){
    //   futureString = err.toString();
    //   print('error: $futureString');
    // }
    // if(futureString != null){
    //   print('tenemos información');
    // }
  }

  Widget callPage(int actualPage){
    switch(actualPage){
      case 0 : return MapsPage();
      case 1 : return AddressesPage();
      default: return MapsPage();
    }
  }

  Widget getBottomNavigationBar(){
    return BottomNavigationBar(
      currentIndex: this.currentIndex,
      onTap: (index){
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
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        ),
      ],
    );
  }
}