import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/global/theme/colors/app_color.dart';
import '../../../core/utils/strings.dart';
import '../../../core/utils/values.dart';
import '../components/see_more_movies/movie_details_component.dart';
import '../components/see_more_movies/movie_image.dart';
import '../controller/movies_events.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../controller/movies_bloc.dart';
import '../controller/movies_state.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  const TopRatedMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()..add(GetTopRatesMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.topRatedMovies,
            style: GoogleFonts.poppins(
              fontSize: AppSize.s18,
              fontWeight: FontWeight.w500,
              letterSpacing: AppSize.s1_2,
            ),
          ),
          centerTitle: true,
          elevation: AppSize.s0,
          backgroundColor: AppColor.darkGrey,
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            switch (state.topRatedState) {
              case RequestState.loading:
                return Center(
                  child: Center(child: CircularProgressIndicator(color: AppColor.lightGrey),),
                );
              case RequestState.loaded:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = state.topRatedMovies[index];
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s180,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          side: BorderSide.none,
                        ),
                        child: Row(
                          children: [
                            MovieImageComponent(
                              imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                            ),
                            MovieDetailsComponent(
                              movieTitle: movie.title,
                              releaseDate: movie.releaseDate,
                              voteAverage: (movie.voteAverage / 2).toStringAsFixed(1),
                              overview: movie.overview,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.topRatedMovies.length,

                );
              case RequestState.error:
                return Center(
                  child: Text(
                    state.topRatedMessage,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
