import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix_clone/models/movie.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addMovie(Movie movie) async {
    await _firestore.collection('movies').add(movie.toMap());
  }

  // Add more Firestore methods as needed for updates, deletions, and queries.
}
