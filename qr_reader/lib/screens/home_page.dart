import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/addresses_page.dart';
import 'package:qr_reader/screens/instagram_page.dart';
import 'package:qr_reader/screens/maps_page.dart';
import 'package:qr_reader/screens/telegram_page.dart';
import 'package:qr_reader/screens/twitter_page.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  static const List<String> _titles = [
    'Mapa',
    'Direcciones',
    'Posts (Instagram)',
    'Tweets (Twitter)',
    'Telegram',
  ];

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(_titles[currentIndex]),
        actions: [
          if (currentIndex != 4)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Borrar todo'),
                    content: const Text(
                      '¿Eliminar todos los registros de esta pestaña?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Borrar'),
                      ),
                    ],
                  ),
                );
                if (confirm == true && context.mounted) {
                  final tipo = CustomNavigationBar.tipos[currentIndex];
                  if (tipo != null) {
                    final provider = Provider.of<ScanListProvider>(
                      context,
                      listen: false,
                    );
                    await DBProvider.db.deleteScansByTipo(tipo);
                    provider.loadScanByType(tipo);
                  }
                }
              },
            ),
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: currentIndex != 4 ? ScanButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    switch (uiProvider.selectedMenuOpt) {
      case 0:
        return MapsPage();
      case 1:
        return AddressesPage();
      case 2:
        return InstagramPage();
      case 3:
        return TwitterPage();
      case 4:
        return TelegramPage();
      default:
        return MapsPage();
    }
  }
}
