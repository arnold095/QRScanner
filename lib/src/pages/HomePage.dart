import 'package:flutter/material.dart';
import 'package:qr_scanner/src/pages/AddressesPage.dart';
import 'package:qr_scanner/src/pages/MapsPage.dart';

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
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
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