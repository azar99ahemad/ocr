// result_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultView extends StatelessWidget {
  final String text;
  const ResultView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extracted Text')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: SelectableText(text),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Copied')),
                );
              },
              child: const Text('Copy Text'),
            )
          ],
        ),
      ),
    );
  }
}
