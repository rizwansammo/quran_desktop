import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ayah.dart';
import '../providers/settings_provider.dart';
import '../services/quran_api.dart';

class AyahCard extends ConsumerStatefulWidget {
  final Ayah ayah;
  final VoidCallback? onTap;

  const AyahCard({
    super.key,
    required this.ayah,
    this.onTap,
  });

  @override
  ConsumerState<AyahCard> createState() => _AyahCardState();
}

class _AyahCardState extends ConsumerState<AyahCard> {
  String? t1;
  String? t2;

  @override
  void initState() {
    super.initState();
    _loadTranslations();
  }

  Future<void> _loadTranslations() async {
    final t1Key = ref.read(translationProvider1);
    final t2Key = ref.read(translationProvider2);

    final translations = await QuranApi.fetchTranslations(
      widget.ayah.surah,
      widget.ayah.ayahNumber,
      [t1Key, t2Key],
    );

    if (translations.isNotEmpty) {
      t1 = translations[0]["text"];
      if (translations.length > 1) {
        t2 = translations[1]["text"];
      }
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final font = ref.watch(arabicFontProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Arabic Text
              Text(
                widget.ayah.textUthmani,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 32,
                  height: 1.8,
                  fontFamily: font,
                ),
              ),

              const SizedBox(height: 12),

              if (t1 != null)
                Text(
                  t1!,
                  style: const TextStyle(fontSize: 16),
                ),

              if (t2 != null) const SizedBox(height: 6),

              if (t2 != null)
                Text(
                  t2!,
                  style: const TextStyle(fontSize: 15),
                ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Ayah ${widget.ayah.ayahNumber}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
