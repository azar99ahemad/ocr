import 'package:flutter/material.dart';
import 'package:ocr/features/text_scanner/view/result_view.dart';

class ScanList extends StatelessWidget {
  final List<String> scans;
  const ScanList({super.key, required this.scans});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: scans.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final text = scans[index];

        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tileColor: const Color(0xFFDCE6B6),
          title: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => ResultView(text: text, index: index,),
            );
          },
        );
      },
    );
  }
}
