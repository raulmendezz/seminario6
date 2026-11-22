import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  static const List<String?> tipos = ['geo', 'http', 'instagram', 'twitter', null];

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      elevation: 0,
      onTap: (int i) {
        final tipo = tipos[i];
        if (tipo != null) {
          Provider.of<ScanListProvider>(context, listen: false)
              .loadScanByType(tipo);
        }
        uiProvider.selectedMenuOpt = i;
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt_outlined),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alternate_email),
          label: 'Tweets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.telegram),
          label: 'Telegram',
        ),
      ],
    );
  }
}
