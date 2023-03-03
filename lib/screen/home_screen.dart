import 'package:flutter/material.dart';
import 'package:pelis_fl/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Películas'),
          elevation: 0,
          actions: [
            IconButton(onPressed: () => {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Column(
          children: const [CardSwiperWiget(), MovieSlider()],
        ));
  }
}
