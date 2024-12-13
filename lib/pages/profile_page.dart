import 'package:dmi_bible_app/pages/daily_devotion_page.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture and Name
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Victor Aung",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Streak Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Text(
                      "1",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Daily Streak",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                // Divider
                Container(
                  height: 70, // Adjust height to match your layout
                  width: 1, // Thin vertical line
                  color: Colors.grey[300], // Light grey color
                ),
                Column(
                  children: const [
                    Text(
                      "100",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Best Streak",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Menu List
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Daily Devotion"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 12),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyDevotionScreen()));
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Prayers and Testimonials"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 12),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyDevotionScreen()));
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Donation"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 12),
              onTap: () {},
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Notification"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 12),
              onTap: () {},
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Privacy Policy"),
              // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Feedback & Support"),
              // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
              ),
              title: const Text("Sign Out"),
              // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add sign-out functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
