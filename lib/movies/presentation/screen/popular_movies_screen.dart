import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/core/utils/strings.dart';

import '../controller/movies_events.dart';
import '../../../core/global/theme/colors/app_color.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/values.dart';
import '../controller/movies_bloc.dart';
import '../controller/movies_state.dart';

class PopularMoviesScreen extends StatelessWidget {
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()..add(GetPopularMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.popularMovies,
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
          buildWhen: (previous, current) =>
          previous.popularState != current.popularState,
          builder: (context, state) {
            switch (state.popularState) {
              case RequestState.loading:
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.lightGrey,
                  ),
                );
              case RequestState.loaded:
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = state.popularMovies[index];
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
                            Expanded(
                              flex: 1,
                              child: FadeInUp(
                                from: AppSize.s20,
                                duration: const Duration(milliseconds: AppDuration.d500),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p6),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(AppSize.s10)),
                                    child: CachedNetworkImage(
                                      height: AppSize.s170,
                                      imageUrl: ApiConstance.imageUrl(movie.backdropPath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: FadeInUp(
                                from: AppSize.s20,
                                duration: const Duration(milliseconds: AppDuration.d500),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8,vertical: AppPadding.p20,),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(movie.title,
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: AppSize.s18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            letterSpacing: AppSize.s1,
                                          )),
                                      const SizedBox(height: AppSize.s8),
                                      Row(
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              vertical: AppPadding.p2,
                                              horizontal: AppPadding.p8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(AppSize.s4),
                                            ),
                                            child: Text(
                                              movie.releaseDate.split('-')[0],
                                              style: const TextStyle(
                                                fontSize: AppSize.s16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: AppSize.s16),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: AppSize.s20,
                                              ),
                                              const SizedBox(width: AppSize.s4),
                                              Text(
                                                (movie.voteAverage / 2)
                                                    .toStringAsFixed(1),
                                                style: const TextStyle(
                                                  fontSize: AppSize.s16,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                              const SizedBox(width: AppSize.s4),
                                              Text(
                                                '(${movie.voteAverage})',
                                                style: const TextStyle(
                                                  fontSize: 1.0,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: AppSize.s20),
                                      Text(
                                        movie.overview,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: AppSize.s16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1.2,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.popularMovies.length,

                );
              case RequestState.error:
                return Center(
                  child: Text(
                    state.popularMessage,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
