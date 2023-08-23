import 'package:flutter/material.dart';

class Previews extends StatelessWidget {
  const Previews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Popular this week',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 165.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyData.length,
              itemBuilder: (BuildContext context, int index) {
                final DummyEntry entry = dummyData[index];

                return GestureDetector(
                  onTap: () {
                    // Handle onTap if needed
                  },
                  child: _renderStack(entry),
                );
              }),
        ),
      ],
    );
  }

  Widget _renderStack(DummyEntry entry) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.grey, // Replace with your color
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withAlpha(40), width: 4.0),
          ),
          child: Center(
            child: Text(
              entry.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DummyEntry {
  final String name;

  DummyEntry({required this.name});
}

final List<DummyEntry> dummyData = [
  DummyEntry(name: 'Movie 1'),
  DummyEntry(name: 'Movie 2'),
  DummyEntry(name: 'Movie 3'),
  // Add more dummy data entries if needed
];
