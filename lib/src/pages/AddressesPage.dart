import 'package:flutter/material.dart';
import 'package:qr_scanner/src/bloc/ScansBloc.dart';
import 'package:qr_scanner/src/models/ScanModel.dart';
import 'package:qr_scanner/src/utils/utils.dart' as utils;

class AddressesPage extends StatelessWidget {
final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.setScans();
    return StreamBuilder<List<ScanModel>> (
      stream: scansBloc.scansStreamHttp,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        if(!snapshot.hasData) return Center(child:CircularProgressIndicator());
        final scans = snapshot.data;
        if(scans.length == 0) return Center(child: Text('No hay información'));
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: (Text(scans[i].valor)),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
              subtitle: Text('Id: ${scans[i].id}'),
              onTap: () => utils.openScan(context, scans[i]),
            ),
            onDismissed: (direction) => scansBloc.deleteScan(scans[i].id),
          ),
        );
      }
    );
  }
}