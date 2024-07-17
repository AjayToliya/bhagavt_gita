import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String selectedLanguage = 'English'; // Default language

  void changeLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
  }
}
