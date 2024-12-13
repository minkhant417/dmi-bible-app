import 'package:dmi_bible_app/pages/bookmark_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Bible App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>BookmarkScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            color: Colors.black,
            onPressed: () {
              // Menu action
            },
          ),
          IconButton(
            icon: const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey,
            ),
            onPressed: () {
              // Profile action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for featured content
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 24),

            // Your Reading Plan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Reading Plan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // "See All" action
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // This Month Theme
            const Text(
              "This Month Theme",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
