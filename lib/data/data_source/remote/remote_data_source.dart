import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:robin_book/domain/models/author/author.dart';
import 'package:robin_book/domain/models/edition/work_editions.dart';
import 'package:robin_book/domain/models/work/work.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

/// Class for communicating to the OpenLibrary api.
class RemoteDataSource {
  static const baseUrl = 'https://openlibrary.org';

  /// Returns a [WorkSearch] related the the [keyword], [limit], and [offset].
  Future<WorkSearch?> searchWorksByTitleOrAuthor({
    required String keyword,
    required int limit,
    required int offset
  }) async {
    Uri url = Uri.parse('$baseUrl/search.json?q=$keyword'
        '&limit=$limit&offset=$offset&fields=key,cover_i,title');
    try {
      http.Response response = await http.get(url);
      WorkSearch workSearch = WorkSearch.fromJson(jsonDecode(response.body));
      return workSearch;
    } catch (e) {
      return null;
    }
  }

  /// Returns a [Work] related to the [key].
  Future<Work?> getWork({
    required String key,
  }) async {
    Uri url = Uri.parse('$baseUrl$key.json');
    try {
      http.Response response = await http.get(url);
      Work work = Work.fromJson(jsonDecode(response.body));
      return work;
    } catch (e) {
      return null;
    }
  }

  /// Returns the [WorkEditions] related to the [key], [limit], and [offset].
  Future<WorkEditions?> getWorkEditions({
    required String key,
    required int limit,
    required int offset
  }) async {
    Uri url = Uri.parse('$baseUrl$key/editions.json'
        '?limit=$limit&offset=$offset');
    try {
      http.Response response = await http.get(url);
      WorkEditions workEditions = WorkEditions.fromJson(jsonDecode(response.body));
      return workEditions;
    } catch (e) {
      return null;
    }
  }

  /// Returns an [Author] related to the [key].
  Future<Author?> getAuthor({
    required String key,
  }) async {
    Uri url = Uri.parse('$baseUrl$key.json');
    try {
      http.Response response = await http.get(url);
      Author author = Author.fromJson(jsonDecode(response.body));
      return author;
    } catch (e) {
      return null;
    }
  }
}