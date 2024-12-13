import 'package:dmi_bible_app/pages/reading_plan_detail_page.dart';
import 'package:flutter/material.dart';

class PowerVersesScreen extends StatelessWidget {
  const PowerVersesScreen({super.key});

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
              // Bookmark action
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
            // Search Bar
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              alignment: Alignment.centerLeft,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none, // Removes the default underline
                ),
                onChanged: (value) {
                },
              ),
            ),

            const SizedBox(height: 16),

            // Chips Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                children: List.generate(7, (index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        right: 8), // Add spacing between items
                    height: 32,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 24),

            // Verses to Memorize Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Verses to Memorize",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // See All action
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
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 24),

            // Reading Plans Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Reading Plans",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // See All action
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
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadingPlanDetailScreen()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
