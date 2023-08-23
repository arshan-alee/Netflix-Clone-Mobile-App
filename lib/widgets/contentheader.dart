import 'package:flutter/material.dart';
import 'package:netflix_clone/widgets/verticaliconbutton.dart';

class ContentHeader extends StatelessWidget {
  ContentHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 500,
        color: Colors.blue, // Replace with your desired color
      ),
      Container(
        height: 500,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      ),
      Positioned(
        bottom: 120,
        child: SizedBox(
          width: 250,
          child: Text(
            dummyFeatured.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 88,
        child: SizedBox(
          width: 250,
          child: Text(
            dummyFeatured.tags.replaceAll(", ", " • "),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      Positioned(
        right: 0,
        left: 0,
        bottom: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Spacer(),
            VerticalIconButton(
              icon: Icons.add,
              title: 'Watchlist',
              tap: () {},
            ),
            const SizedBox(width: 40),
            MaterialButton(
              color: Colors.white,
              child: Row(
                children: const [Icon(Icons.play_arrow), Text("Play")],
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 40),
            VerticalIconButton(
              icon: Icons.info,
              title: 'Info',
              tap: () {},
            ),
            const Spacer(),
          ],
        ),
      )
    ]);
  }
}

class DummyEntry {
  final String name;
  final String tags;

  DummyEntry({
    required this.name,
    required this.tags,
  });
}

final DummyEntry dummyFeatured = DummyEntry(
  name: 'Dummy Movie',
  tags: 'Action, Adventure',
);
