import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie.dart';

class Previews extends StatelessWidget {
  final Future<List<Movie>> movies;

  Previews({Key? key, required this.movies}) : super(key: key);

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
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Popular this week',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(
                height: 165.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= movies.length) {
                      return Container(); // Return an empty container if the index is out of bounds
                    }
                    final Movie movie = movies[index];

                    return GestureDetector(
                        onTap: () {
                          // Handle onTap if needed
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey, // Replace with your color
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white.withAlpha(40), width: 4.0),
                            image: DecorationImage(
                                image: NetworkImage(movie.posterPath),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high),
                          ),
                        ));
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
