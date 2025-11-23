import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ayah.dart';

class QuranApi {
  static const String base = "https://api.quran.com/api/v4";

  /// ----------------------
  /// FETCH AYAT OF A SURAH
  /// ----------------------
  static Future<List<Ayah>> fetchAyat(int surahNumber) async {
    final url = Uri.parse(
      "$base/verses/by_chapter/$surahNumber?language=ar&words=false&fields=text_uthmani,text_indopak",
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception("Failed to fetch ayat for Surah $surahNumber");
    }

    final data = jsonDecode(res.body);
    final ayatJson = data["verses"] as List;

    return ayatJson.map((item) {
      return Ayah(
        id: item["id"] ?? 0,
        surah: item["chapter_id"] ?? surahNumber,
        ayahNumber: item["verse_number"] ?? 0,
        textUthmani: item["text_uthmani"] ?? "",
        textIndopak: item["text_indopak"] ?? "",
        textKfgq: "",
      );
    }).toList();
  }

  /// ----------------------
  /// FETCH TRANSLATIONS FOR AN AYAH
  /// ----------------------
  static Future<List<Map<String, dynamic>>> fetchTranslations(
      int surah, int ayah, List<String> translationIds) async {
    final joined = translationIds.join(",");
    final url = Uri.parse(
      "$base/verses/by_key/$surah:$ayah/translations?translations=$joined",
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      return [];
    }

    final data = jsonDecode(res.body);

    return List<Map<String, dynamic>>.from(data["translations"]);
  }

  /// ----------------------
  /// FETCH TAFSIR FOR AYAH
  /// ----------------------
  static Future<String?> fetchTafsir(
      int surah, int ayah, String tafsirSource) async {
    final url = Uri.parse(
      "$base/tafsirs/$tafsirSource/by_ayah/$surah:$ayah",
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      return null;
    }

    final data = jsonDecode(res.body);
    final tafsirList = data["tafsirs"] as List<dynamic>;

    if (tafsirList.isEmpty) return null;

    return tafsirList.first["text"];
  }
}
