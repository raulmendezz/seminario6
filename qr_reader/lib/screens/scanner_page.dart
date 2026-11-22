import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScannerPage extends StatefulWidget {
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool _detected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear QR')),
      body: MobileScanner(
        onDetect: (capture) async {
          if (_detected) return;
          final barcode = capture.barcodes.firstOrNull;
          if (barcode?.rawValue == null) return;

          _detected = true;
          final value = barcode!.rawValue!;
          final provider = Provider.of<ScanListProvider>(
            context,
            listen: false,
          );

          await provider.newScan(value);

          if (mounted) Navigator.pop(this.context);
        },
      ),
    );
  }
}
