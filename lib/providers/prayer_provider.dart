import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class PrayerProvider with ChangeNotifier {
  PrayerTimes? _prayerTimes;
  Position? _currentPosition;
  String _locationName = "جاري التحديد...";

  PrayerTimes? get prayerTimes => _prayerTimes;
  String get locationName => _locationName;

  Future<void> fetchPrayerTimes() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    
    final coordinates = Coordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.shafi;

    _prayerTimes = PrayerTimes.today(coordinates, params);
    _locationName = "موقعك الحالي"; // Ideally use geocoding here
    notifyListeners();
  }

  String getPrayerTime(Prayer prayer) {
    if (_prayerTimes == null) return "--:--";
    DateTime time;
    switch (prayer) {
      case Prayer.fajr: time = _prayerTimes!.fajr; break;
      case Prayer.dhuhr: time = _prayerTimes!.dhuhr; break;
      case Prayer.asr: time = _prayerTimes!.asr; break;
      case Prayer.maghrib: time = _prayerTimes!.maghrib; break;
      case Prayer.isha: time = _prayerTimes!.isha; break;
      default: return "--:--";
    }
    return DateFormat.jm('ar').format(time);
  }
}
