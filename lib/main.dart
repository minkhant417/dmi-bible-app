import 'dart:math';

import 'package:dmi_bible_app/pages/chapter_detail.dart';
import 'package:dmi_bible_app/pages/home.dart';
import 'package:dmi_bible_app/provider/bible_provider.dart';
import 'package:dmi_bible_app/provider/bottom_navigation_provider.dart';
import 'package:dmi_bible_app/provider/highlight_provider.dart';
import 'package:dmi_bible_app/services/database_helper.dart';
import 'package:dmi_bible_app/services/json_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure database initialization
  final dbHelper = BibleDatabaseHelper();
  await dbHelper.database; // Initializes the database
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BibleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HighlightProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
      ],
      child: MaterialApp(
        title: 'Bible App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const DataLoaderScreen(),
      ),
    );
  }
}

class DataLoaderScreen extends StatefulWidget {
  const DataLoaderScreen({super.key});

  @override
  State<DataLoaderScreen> createState() => _DataLoaderScreenState();
}

class _DataLoaderScreenState extends State<DataLoaderScreen> {
  double _progress = 0.0;
  bool _isLoading = false;
  bool _dataChecked =
      false; // Add a flag to track if the data check is complete

  Future<void> _loadData() async {
    final dbHelper = BibleDatabaseHelper();
    // Check if the database already contains the required number of verses
    final currentRowCount = await dbHelper.getVerseCount();

    setState(() {
      _dataChecked = true;
    });

    if (currentRowCount < 30800) {
      // Start loading if data is missing
      setState(() {
        _isLoading = true;
        _progress = 0.0; // Reset progress
      });
      await loadDataInBackground(
        onProgress: (double progress) {
          setState(() {
            _progress = progress; // Update progress
          });
        },
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // Start loading data when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    // List of screens to navigate to
    final List<Widget> _screens = [
      const BibleApp(), 
      const ChapterDetailScreen(),
      const ChapterDetailScreen(),
      const ChapterDetailScreen(),
      
    ];

    return Scaffold(
      body: Consumer<BottomNavigationBarProvider>(
        builder: (context, provider, child) {
          // Use currentIndex to determine which screen to show
          return !_dataChecked
              ? const Center(
                  child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator()),
                )
              : _isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          margin: const EdgeInsets.only(bottom: 32),
                          child: Image.asset(
                            'assets/images/bible.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                            value: _progress,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                            "Loading : ${(_progress * 100).toStringAsFixed(0)}%"),
                      ],
                    )
                  : _screens[provider.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationBarProvider>(
        builder: (context, provider, child) {
          return BottomNavigationBar(
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: FaIcon(FontAwesomeIcons.home, size: 20,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.book, size: 20,),
                label: 'Bible',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.fire, size: 20,),
                label: 'Fire',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userGroup, size: 20,),
                label: 'Users',
              ),
            ],
            currentIndex: provider.currentIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: const Color.fromARGB(255, 132, 165, 248),
            onTap: (index) {
              provider.updateIndex(index);
            },
          );
        },
      ),
    );
  }
}
