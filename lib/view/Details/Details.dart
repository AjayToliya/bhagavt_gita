import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/language.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    String currentLanguage = languageProvider.selectedLanguage;

    Map chapter = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          '${chapter['name']}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF8B5A2B),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.language, color: Colors.white),
            onSelected: (String language) {
              languageProvider.changeLanguage(language);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'English',
                child: Text('English'),
              ),
              const PopupMenuItem<String>(
                value: 'Hindi',
                child: Text('Hindi'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFEBCD), // Light golden beige
              Color(0xFFFFD700), // Golden yellow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: chapter['verses'].length,
            itemBuilder: (context, i) {
              Map verse = chapter['verses'][i];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                color: Color(0xFFFFF8E1),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  title: Text(
                    'Sloka ${verse['Sloka'].toString()}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        verse['Verse'],
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _getVerseContent(verse, currentLanguage),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Show Bottom Sheet when a verse is tapped
                    showVerseBottomSheet(
                      context,
                      verse['Sloka'].toString(),
                      verse,
                      currentLanguage,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Function to get the verse content based on the selected language
  String _getVerseContent(Map verse, String language) {
    switch (language) {
      case 'Hindi':
        return verse['Translation_Hindi'];
      case 'English':
      default:
        return verse['Translation_English'];
    }
  }

  // Bottom Sheet function to show the content of the verse with translations
  void showVerseBottomSheet(
    BuildContext context,
    String slokaNumber,
    Map verse,
    String currentLanguage,
  ) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFEBCD), // Light golden beige
                  Color(0xFFFFD700), // Golden yellow
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  "Sloka $slokaNumber",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513), // Deep brown for Sloka number
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16), // Added spacing between elements

                // Sanskrit Verse
                Text(
                  verse['Verse'], // Sanskrit verse
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic, // Italic for Sanskrit
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24), // Larger space for sectioning

                // Hindi Section Title
                Text(
                  "Translation (Hindi):",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        Color(0xFF8B4513), // Same deep brown for section title
                  ),
                ),
                SizedBox(height: 10),

                // Hindi Translation
                Text(
                  verse['Translation_Hindi'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign
                      .justify, // Justify for better paragraph readability
                ),
                SizedBox(height: 24), // Space before the next translation

                // English Section Title
                Text(
                  "Translation (English):",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513), // Deep brown for section title
                  ),
                ),
                SizedBox(height: 10),

                // English Translation
                Text(
                  verse['Translation_English'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 24), // Space before the button

                // Close Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the Bottom Sheet
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8B4513), // Deep brown for button
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded button
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
