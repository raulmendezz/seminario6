import 'package:flutter/material.dart';
import 'package:qr_reader/screens/map_page.dart';
/*import 'package:qr_reader/widgets/custom_navigatorbar.dart';*/
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              //logica
            },
          ),
        ],
      ),
      body: MapPage(),

      bottomNavigationBar: BottomAppBar(),

      floatingActionButton: const ScanButton(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
