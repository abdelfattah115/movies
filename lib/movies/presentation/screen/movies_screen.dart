import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/now_playing_component.dart';
import '../components/see_more_component.dart';
import '../components/top_rates_component.dart';
import '../controller/movies_events.dart';
import '../../../core/services/service_locator.dart';
import '../components/popular_component.dart';
import '../controller/movies_bloc.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatesMoviesEvent()
        ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NowPlayingComponent(),
              SeeMoreComponent(
                  title: "Popular",
                  onTap: () {
                    /// TODO : NAVIGATION TO POPULAR SCREEN
                  }),
              const PopularComponent(),
              SeeMoreComponent(
                  title: 'Top Rated',
                  onTap: () {
                    /// TODO : NAVIGATION TO Top Rated Movies Screen
                  }),
              const TopRatedComponent(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
