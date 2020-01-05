import 'dart:async';

import 'package:qr_scanner/src/bloc/Validator.dart';
import 'package:qr_scanner/src/models/ScanModel.dart';
import 'package:qr_scanner/src/providers/DbProvider.dart';

class ScansBloc with Validator {
  static final ScansBloc _scansBloc = new ScansBloc._internal();

  factory ScansBloc() {
    return _scansBloc;
  }

  ScansBloc._internal() {
    //Obtener Scans de la BDD.
    this.setScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validateHttp);

  dispose() {
    _scansController?.close();
  }

  setScans() async {
    _scansController.sink.add( await DBProvider.db.getAllScans());
  }

  deleteScan(int id) async{
    await DBProvider.db.deleteScan(id);
    this.setScans();
  }

  deleteAllScans() async{
    await DBProvider.db.deleteAllScan();
    this.setScans();
  }

  addScan(ScanModel scan) async{
    await DBProvider.db.newScanRaw(scan);
    this.setScans(); 
  }
}
