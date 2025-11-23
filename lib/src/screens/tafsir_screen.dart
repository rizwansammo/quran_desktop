import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ayah.dart';
import '../providers/settings_provider.dart';
import '../services/quran_api.dart';

class TafsirScreen extends ConsumerStatefulWidget {
  final Ayah ayah;

  const TafsirScreen({
    super.key,
    required this.ayah,
  });

  @override
  ConsumerState<TafsirScreen> createState() => _TafsirScreenState();
}

class _TafsirScreenState extends ConsumerState<TafsirScreen> {
  String? tafsirText;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadTafsir();
  }

  Future<void> _loadTafsir() async {
    final tafsirSource = ref.read(tafsirProvider);

    try {
      final result = await QuranApi.fetchTafsir(
        widget.ayah.id, // FIXED ✔
        tafsirSource, // FIXED ✔
      );

      tafsirText = result ?? "No tafsir available for this ayah.";
    } catch (e) {
      error = e.toString();
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final arabicFont = ref.watch(arabicFontProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tafsir • Surah ${widget.ayah.surah}"),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text("Error: $error"))
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Arabic Ayah
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.ayah.textUthmani,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 32,
                          height: 1.8,
                          fontFamily: arabicFont,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      "Surah ${widget.ayah.surah} — Ayah ${widget.ayah.ayahNumber}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tafsir Text
                    Text(
                      tafsirText ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
    );
  }
}
