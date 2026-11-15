import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;

class QuranProvider with ChangeNotifier {
  int _lastReadSurah = 1;
  int _lastReadAyah = 1;

  int get lastReadSurah => _lastReadSurah;
  int get lastReadAyah => _lastReadAyah;

  void updateLastRead(int surah, int ayah) {
    _lastReadSurah = surah;
    _lastReadAyah = ayah;
    notifyListeners();
  }

  List<Map<String, dynamic>> getAllSurahs() {
    return List.generate(114, (index) {
      int surahNumber = index + 1;
      return {
        'number': surahNumber,
        'name': quran.getSurahNameArabic(surahNumber),
        'verses': quran.getVerseCount(surahNumber),
        'revelation': quran.getPlaceOfRevelation(surahNumber) == 'Makkah' ? 'مكية' : 'مدنية',
      };
    });
  }
}
