import 'package:flutter/material.dart';
import 'surah_screen.dart';

class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  static final List<Map<String, dynamic>> surahs = [
    {"number": 1, "name": "الفاتحة", "english": "Al-Fatihah", "ayat": 7},
    {"number": 2, "name": "البقرة", "english": "Al-Baqarah", "ayat": 286},
    {"number": 3, "name": "آل عمران", "english": "Aal-Imran", "ayat": 200},
    {"number": 4, "name": "النساء", "english": "An-Nisa", "ayat": 176},
    {"number": 5, "name": "المائدة", "english": "Al-Ma'idah", "ayat": 120},
    // TODO: Add all surahs (I will provide full list later)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran Desktop"),
      ),
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, i) {
          final s = surahs[i];

          return ListTile(
            title: Text(
              "${s['number']}. ${s['english']}",
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              s['name'],
              style: const TextStyle(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
            trailing: Text(
              "${s['ayat']} Ayat",
              style: const TextStyle(fontSize: 14),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SurahScreen(
                    surahNumber: s['number'],
                    surahNameAr: s['name'],
                    surahNameEn: s['english'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
