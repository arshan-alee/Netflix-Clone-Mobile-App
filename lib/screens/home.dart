import 'package:flutter/material.dart';
import 'package:netflix_clone/api/api.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/widgets/contentbar.dart';
import 'package:netflix_clone/widgets/contentheader.dart';
import 'package:netflix_clone/widgets/contentlist.dart';
import '../widgets/previews.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

  late Future<List<Movie>> trendingMovies;
  // late Future<List<Movie>> nowPlayingMovies;

  @override
  void initState() {
    trendingMovies = Api.getTrendingMovies(1);
    // nowPlayingMovies = Api.getNowPlayingMovies(1);
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 70.0),
        child: ContentBar(
          scrollOffset: _scrollOffset,
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              nowPlayingMovies: trendingMovies,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
              child: Previews(trendingMovies: trendingMovies),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: ContentList(
                title: 'Only on Netflix',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              title: 'New releases',
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                title: 'Animation',
              ),
            ),
          ),
        ],
      ),
    );
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
