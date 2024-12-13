import 'package:dmi_bible_app/pages/bookmark_page.dart';
import 'package:flutter/material.dart';

class PrayerTestimonialScreen extends StatefulWidget {
  const PrayerTestimonialScreen({super.key});

  @override
  State<PrayerTestimonialScreen> createState() =>
      _PrayerTestimonialScreenState();
}

class _PrayerTestimonialScreenState extends State<PrayerTestimonialScreen> {
  bool isPrayersSelected = true;

  final List<String> prayers = [
    "Anna’s Math Exam",
    "Nelson’s first day in school",
    "Healing for Elias",
    "Participants of the Alpha Course",
    "Peace for Myanmar",
    "Healing of breast cancer with Chris",
    "Protection & blessing in children groups",
    "Wisdom for our politicians",
    "Healing for Mary",
    "Protection for Chris",
  ];

  final List<Map<String, String>> testimonials = [
    {
      "name": "Saw Aung Thin",
      "date": "Oct 12, 2024",
      "message":
          "There was a time when everything around me seemed to crumble. I was battling anxiety, and every day felt like an uphill battle. But when I turned to God in prayer, a sense of peace washed over me. It didn't happen overnight, but over time I experienced true peace."
    },
    {
      "name": "Naw Cherry Aye",
      "date": "Oct 12, 2024",
      "message":
          "I struggled with illness for years, and despite all the medical treatments, nothing seemed to work. I began to lose hope. But then I turned to God, surrendering my fears and doubts. Through prayer, I found strength, and over time, my health began improving."
    },
    {
      "name": "Daw Swe Sin Oo",
      "date": "Oct 12, 2024",
      "message":
          "I used to live a life filled with anger and bitterness. I chased after things that only left me feeling empty inside. But when I finally let God into my heart, everything changed. He transformed me from the inside out, showing me what it means to truly live."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: const Text(
          "Bible App",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookmarkScreen()));
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
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tabs
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: Stack(
                  children: [
                    // Animated Background
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: isPrayersSelected
                          ? 0
                          : MediaQuery.of(context).size.width / 2.2,
                      width: MediaQuery.of(context).size.width / 2.2,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    // Tabs (Prayers and Testimonials)
                    Row(
                      children: [
                        // PRAYERS TAB
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPrayersSelected = true;
                              });
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors
                                    .transparent, // Transparent to show the background
                              ),
                              child: Text(
                                "Prayers",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isPrayersSelected
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // TESTIMONIALS TAB
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isPrayersSelected = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors
                                    .transparent, // Transparent to show the background
                              ),
                              child: Text(
                                "Testimonials",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: !isPrayersSelected
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // PRAYER SECTION
              child: isPrayersSelected
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container Below Tabs
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Prayers",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: prayers.length,
                            // SEPERATE LINE
                            separatorBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                thickness: 0.1, // Thinner line
                                color: Colors.grey,
                              ),
                            ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                title: Text(
                                  prayers[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  :
                  // TESTIMONIALS
                  ListView.builder(
                      itemCount: testimonials.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey,
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              testimonials[index]['name']!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              testimonials[index]['date']!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.bookmark_border,
                                        color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  testimonials[index]['message']!,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
