import 'package:flutter/material.dart';
import 'package:pelis_fl/providers/movies_provider.dart';
import 'package:pelis_fl/search/search_delegate.dart';
import 'package:pelis_fl/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Películas'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSearchDelegate()),
                icon: const Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiperWiget(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                movies: moviesProvider.upcomingMovies,
                title: 'Upcoming movies ',
                onNextPage: () => moviesProvider.getUpcomingMovies(),
              ),
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Popular movies',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
