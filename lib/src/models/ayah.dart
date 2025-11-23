class Ayah {
  final int id;           // Unique ID from API or local DB
  final int surah;        // Surah number
  final int ayahNumber;   // Ayah number inside the Surah
  final String textUthmani;
  final String textIndopak;
  final String textKfgq;

  Ayah({
    required this.id,
    required this.surah,
    required this.ayahNumber,
    required this.textUthmani,
    required this.textIndopak,
    required this.textKfgq,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "surah": surah,
      "ayah": ayahNumber,
      "text_uthmani": textUthmani,
      "text_indopak": textIndopak,
      "text_kfgq": textKfgq,
    };
  }

  factory Ayah.fromMap(Map<String, dynamic> map) {
    return Ayah(
      id: map["id"],
      surah: map["surah"],
      ayahNumber: map["ayah"],
      textUthmani: map["text_uthmani"],
      textIndopak: map["text_indopak"],
      textKfgq: map["text_kfgq"],
    );
  }
}
