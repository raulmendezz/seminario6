import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class TwitterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'twitter');
  }
}
