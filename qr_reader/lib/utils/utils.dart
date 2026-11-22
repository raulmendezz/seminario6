import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final url = Uri.parse(scan.valor);

  if (scan.tipo == 'geo') {
    Navigator.pushNamed(context, 'map', arguments: scan);
    return;
  }

  // Para Twitter e Instagram intentamos abrir la app nativa primero
  if (scan.tipo == 'twitter' || scan.tipo == 'instagram') {
    try {
      final opened = await launchUrl(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (opened) return;
    } catch (_) {}
    // Fallback: abre en navegador
    await launchUrl(url, mode: LaunchMode.externalApplication);
    return;
  }

  // http genérico
  final messenger = ScaffoldMessenger.of(context);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    messenger.showSnackBar(
      SnackBar(content: Text('No se pudo abrir: ${scan.valor}')),
    );
  }
}
