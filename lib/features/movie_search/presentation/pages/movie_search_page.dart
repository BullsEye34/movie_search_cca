import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/di/injection_container.dart';
import 'package:movie_search/features/movie_search/presentation/bloc/moviesearch_bloc.dart';
import 'package:movie_search/features/movie_search/presentation/widgets/loading_widget.dart';
import 'package:movie_search/features/movie_search/presentation/widgets/message_display.dart';
import 'package:movie_search/features/movie_search/presentation/widgets/movie_controls.dart';
import 'package:movie_search/features/movie_search/presentation/widgets/movie_display.dart';

class MovieSearchpage extends StatelessWidget {
  const MovieSearchpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Movie Search',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  BlocProvider<MoviesearchBloc> buildBody(context) {
    return BlocProvider(
      create: (context) => sl<MoviesearchBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Top Half
              MovieSearchControls(),
              const SizedBox(
                height: 10,
              ),

              BlocBuilder<MoviesearchBloc, MoviesearchState>(
                builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<MoviesearchBloc>(context)
                        .add(GetTrendingMoviesEvent());
                    return const Placeholder();
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return MovieDiplay(
                      movieSearch: state.movieSearch,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Placeholder(),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
