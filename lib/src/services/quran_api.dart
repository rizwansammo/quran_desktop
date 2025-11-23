import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/ayah.dart';

class QuranApi {
  static const String base = "https://api.quran.com/api/v4";

  /// -----------------------------
  /// FETCH AYAT OF A SURAH (Arabic)
  /// -----------------------------
  static Future<List<Ayah>> fetchAyat(int surahNumber) async {
    final url = Uri.parse(
      "$base/verses/by_chapter/$surahNumber?fields=text_uthmani,text_indopak&per_page=300",
    );

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception("Failed to load surah $surahNumber");
    }

    final json = jsonDecode(res.body);
    final List verses = json["verses"];

    return verses.map((v) {
      return Ayah(
        id: v["id"] ?? 0, // ayah ID
        surah: v["chapter_id"] ?? surahNumber,
        ayahNumber: v["verse_number"] ?? 0,
        textUthmani: v["text_uthmani"] ?? "",
        textIndopak: v["text_indopak"] ?? "",
        textKfgq: "",
      );
    }).toList();
  }

  /// ---------------------------------------
  /// FETCH TRANSLATIONS FOR A SINGLE AYAH
  /// ---------------------------------------
  static Future<List<Map<String, dynamic>>> fetchTranslations(
      int surah, int ayah, List<String> translationIds) async {
    if (translationIds.isEmpty) return [];

    final joined = translationIds.join(",");

    final url = Uri.parse(
      "$base/verses/by_key/$surah:$ayah/translations?translations=$joined",
    );

    final res = await http.get(url);
    if (res.statusCode != 200) return [];

    final json = jsonDecode(res.body);

    return List<Map<String, dynamic>>.from(json["translations"] ?? []);
  }

  /// ---------------------------------------
  /// FETCH TAFSIR (Correct Quran.com format)
  /// ---------------------------------------
  static Future<String?> fetchTafsir(int ayahId, String tafsirSource) async {
    final url = Uri.parse(
      "$base/tafsirs/$tafsirSource/by_ayah/$ayahId",
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(res.body);
    final tafsir = data["tafsir"];

    if (tafsir == null || tafsir["text"] == null) return null;

    return tafsir["text"];
  }
}
