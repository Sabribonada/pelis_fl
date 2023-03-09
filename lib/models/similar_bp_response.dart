// To parse this JSON data, do
//
//     final similarBpResponse = similarBpResponseFromMap(jsonString);

import 'dart:convert';

import 'package:pelis_fl/models/models.dart';

class SimilarBpResponse {
  SimilarBpResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SimilarBpResponse.fromMap(Map<String, dynamic> json) =>
      SimilarBpResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  factory SimilarBpResponse.fromJson(String str) =>
      SimilarBpResponse.fromMap(json.decode(str));
}
