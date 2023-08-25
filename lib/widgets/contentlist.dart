import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie.dart';

class ContentList extends StatelessWidget {
  final String title;
  final Future<List<Movie>> movies;

  ContentList({
    Key? key,
    required this.title,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            List<Movie> movies = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, bottom: 10, top: 20),
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
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Movie movie = movies[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle onTap if needed
                        },
                        child: Container(
                            height: 100,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: Image.network(
                              movie.posterPath,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            )),
                      );
                    },
                  ),
                )
              ],
            );
          }
        });
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
