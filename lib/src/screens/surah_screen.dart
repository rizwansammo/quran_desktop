import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/quran_api.dart';
import '../models/ayah.dart';
import '../widgets/ayah_card.dart';
import '../providers/settings_provider.dart';
import 'tafsir_screen.dart';

class SurahScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;

  const SurahScreen({
    super.key,
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
  });

  @override
  ConsumerState<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends ConsumerState<SurahScreen> {
  bool loading = true;
  List<Ayah> ayat = [];
  String? error;

  @override
  void initState() {
    super.initState();
    _loadAyat();
  }

  Future<void> _loadAyat() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      ayat = await QuranApi.fetchAyat(widget.surahNumber);
    } catch (e) {
      error = e.toString();
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.surahNumber}. ${widget.surahNameEn}"),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggle();
            },
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : ListView.builder(
                  itemCount: ayat.length,
                  itemBuilder: (context, i) {
                    final a = ayat[i];

                    return AyahCard(
                      ayah: a,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TafsirScreen(ayah: a),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
