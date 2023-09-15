import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/widgets/verticaliconbutton.dart';

class ContentHeader extends StatelessWidget {
  final Future<List<Movie>> nowPlayingMovies;

  ContentHeader({Key? key, required this.nowPlayingMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: nowPlayingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while waiting
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            List<Movie> movies = snapshot.data!;
            return Stack(alignment: Alignment.center, children: [
              Container(
                height: 470,
                color: Colors.blue, // Replace with your desired color
              ),
              Container(
                height: 470,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  image: DecorationImage(
                      image: NetworkImage(movies[8].backDropPath),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high),
                ),
              ),
              Positioned(
                bottom: 120,
                child: SizedBox(
                  width: 250,
                  child: Text(
                    movies[8].title,
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
                    movies[8].genres.join(" • "),
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
        });
  }
}

// class DummyEntry {
//   final String name;
//   final String tags;

//   DummyEntry({
//     required this.name,
//     required this.tags,
//   });
// }

// final DummyEntry dummyFeatured = DummyEntry(
//   name: 'Dummy Movie',
//   tags: 'Action, Adventure',
// );
