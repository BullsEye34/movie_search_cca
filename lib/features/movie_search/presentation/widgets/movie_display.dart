import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class MovieDiplay extends StatelessWidget {
  MovieSearch movieSearch;
  MovieDiplay({required this.movieSearch, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.25,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: movieSearch.results.length,
          itemBuilder: (context, index) {
            return listTile(movieSearch, index);
          },
        ));
  }

  listTile(MovieSearch movieSearch, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () => launch((movieSearch.results[index].mediaType == "tv")
              ? "https://www.themoviedb.org/tv/${movieSearch.results[index].id}"
              : "https://www.themoviedb.org/movie/${movieSearch.results[index].id}"),
          child: Container(
              //height: 120,
              child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://image.tmdb.org/t/p/original/" +
                              movieSearch.results[index].posterPath),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                flex: 2,
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieSearch.results[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      movieSearch.results[index].overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      );
}
