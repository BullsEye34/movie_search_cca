import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_search/features/movie_search/presentation/bloc/moviesearch_bloc.dart';

class MovieSearchControls extends StatefulWidget {
  const MovieSearchControls({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieSearchControls> createState() => _MovieSearchControlsState();
}

class _MovieSearchControlsState extends State<MovieSearchControls> {
  late TextEditingController textEditingController =
      new TextEditingController();
  late String inputString;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        inputString = value;
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      controller: textEditingController,
      onSubmitted: (value) => addMovieSearch(),
      decoration: InputDecoration(
        hintText: "Search for a Movie!",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }

  void addMovieSearch() {
    textEditingController.clear();
    BlocProvider.of<MoviesearchBloc>(context)
        .add(GetMovieForSearchEvent(title: inputString));
  }
}
