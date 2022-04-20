import 'package:movie_search/features/movie_search/domain/entities/movie_search.dart';

class MovieSearchModel extends MovieSearch {
  MovieSearchModel({required List<Result> results}) : super(results: results);

  factory MovieSearchModel.fromJson(Map<String, dynamic> json) =>
      MovieSearchModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
