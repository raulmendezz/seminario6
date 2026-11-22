import 'package:flutter/material.dart';
import 'package:qr_reader/screens/scanner_page.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ScannerPage()),
        );
      },
    );
  }
}
