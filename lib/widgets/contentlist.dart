import 'package:flutter/material.dart';

class ContentList extends StatelessWidget {
  final String title;
  final bool _rounded;

  ContentList({
    Key? key,
    required this.title,
    bool rounded = false,
  })  : _rounded = rounded,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 10, top: 20),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyContentList.length,
            itemBuilder: (context, int count) {
              final DummyEntry current = dummyContentList[count];
              return GestureDetector(
                onTap: () {
                  // Handle onTap if needed
                },
                child: Container(
                    height: 100,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Image.network(
                      current.imageUrl, // Replace with your dummy image URL
                      fit: BoxFit.cover,
                    )),
              );
            },
          ),
        )
      ],
    );
  }
}

class DummyEntry {
  final String imageUrl;

  DummyEntry({required this.imageUrl});
}

final List<DummyEntry> dummyContentList = [
  DummyEntry(
      imageUrl:
          'https://cosmicbook.news/images1/batman-robert-pattinson-poster-dc-fandome-2.jpg'),
  DummyEntry(
      imageUrl:
          'https://cosmicbook.news/images1/batman-robert-pattinson-poster-dc-fandome-2.jpg'),
  DummyEntry(
      imageUrl:
          'https://cosmicbook.news/images1/batman-robert-pattinson-poster-dc-fandome-2.jpg'),
  // Add more dummy entries with image URLs
];
