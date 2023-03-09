import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelis_fl/models/models.dart';
import 'package:pelis_fl/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final String movieTitle;
  final int movieId;
  const SimilarMoviesWidget(this.movieTitle, this.movieId);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getSimilarMovies(movieId),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }
          final List<Movie> movie = snapshot.data!;

          return Container(
            width: double.infinity,
            height: 180,
            margin: const EdgeInsets.only(top: 20, bottom: 30),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, int index) {
                  return _MovieCard(movie[index]);
                }),
          );
        });
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: 100,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
