import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CONFIGURACIÓN DEL BOT
// 1. Crea un bot en Telegram hablando con @BotFather y copia el token.
// 2. Añade el bot al grupo https://t.me/+PelQwc5KtmZmMWI0 como administrador.
// 3. Llama a: https://api.telegram.org/bot<TOKEN>/getUpdates
//    y busca el "chat.id" (número negativo) del grupo.
// ─────────────────────────────────────────────────────────────────────────────
const String _botToken = 'TU_BOT_TOKEN';
const String _chatId   = 'TU_CHAT_ID';

class TelegramPage extends StatefulWidget {
  @override
  _TelegramPageState createState() => _TelegramPageState();
}

class _TelegramPageState extends State<TelegramPage> {
  final _controller = TextEditingController();
  bool _sending = false;
  String? _status;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _sending = true;
      _status = null;
    });

    try {
      final url = Uri.parse(
        'https://api.telegram.org/bot$_botToken/sendMessage',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'chat_id': _chatId, 'text': text}),
      );

      if (response.statusCode == 200) {
        _controller.clear();
        setState(() => _status = '¡Mensaje enviado al grupo!');
      } else {
        // Si el bot no está configurado, abre el grupo en Telegram
        await _openGroupFallback();
      }
    } catch (_) {
      await _openGroupFallback();
    } finally {
      setState(() => _sending = false);
    }
  }

  Future<void> _openGroupFallback() async {
    final uri = Uri.parse('https://t.me/+PelQwc5KtmZmMWI0');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    setState(() => _status = 'Configura el bot para envío automático.');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Enviar mensaje al grupo de Telegram',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Escribe tu mensaje aquí...',
              labelText: 'Mensaje',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: _sending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.send),
            label: Text(_sending ? 'Enviando...' : 'Enviar al grupo'),
            onPressed: _sending ? null : _sendMessage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          if (_status != null) ...[
            const SizedBox(height: 12),
            Text(
              _status!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _status!.startsWith('¡')
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
