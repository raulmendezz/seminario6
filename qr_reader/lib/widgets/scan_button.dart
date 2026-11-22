import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        final barcodeScanRes = 'geo:38.5,-0.1';

        final scanListProvider = Provider.of<ScanListProvider>(
          context,
          listen: false,
        );
        scanListProvider.newScan(barcodeScanRes);
      },
    );
  }
}
