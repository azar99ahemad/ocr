import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notescan/shared/storage/scan_storage.dart';
import 'package:notescan/shared/widgets/IconPill_button.dart';
import 'package:notescan/shared/widgets/primary_button.dart';
import 'package:notescan/shared/widgets/topPill_button.dart';
import 'package:share_plus/share_plus.dart';

class ResultView extends StatefulWidget {
  final String text;
  final int? index;
  const ResultView({super.key, required this.text, this.index});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  String? scanId;
  @override
  void initState() {
    super.initState();

    // New scan → save & generate id
    if (widget.index == null) {
      scanId = ScanStorage.save(widget.text);
    }
    // Old scan → fetch existing id
    else {
      scanId = ScanStorage.getIdAt(widget.index!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F5E6),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // ---------- Drag Handle ----------
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // ---------- Top Bar ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  TopPillButton(
                    label: 'Close',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  const Text(
                    'Result',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  if (widget.index != null)
                    IconPillButton(
                      icon: Icons.delete_outline,
                      onTap: () {
                        ScanStorage.deleteAt(widget.index!);
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),

            // ---------- Extracted Text ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE6B6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EXTRACTED TEXT',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SizedBox(
                            width: double.infinity,
                            child: SelectableText(
                              widget.text,
                              style: const TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ---------- Bottom Buttons ----------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Copy Text',
                      icon: Icons.copy,
                      filled: true,
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.text));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Share',
                      icon: Icons.share,
                      filled: false,
                      onTap: () {
                        if (scanId == null) return;

                        final url =
                            'https://notescan.vercel.app/result/$scanId';
                        Share.share(url);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
