import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:robin_book/domain/author/author.dart';
import 'package:robin_book/domain/edition/work_editions.dart';
import 'package:robin_book/domain/work/work.dart';
import 'package:robin_book/domain/work_search/work_search.dart';

class NetworkDataSource {
  static const baseUrl = 'https://openlibrary.org';

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

  Future<Work?> getWork({
    required String key,
  }) async {
    Uri url = Uri.parse('$baseUrl/works/$key.json');
    try {
      http.Response response = await http.get(url);
      Work work = Work.fromJson(jsonDecode(response.body));
      return work;
    } catch (e) {
      return null;
    }
  }

  Future<WorkEditions?> getWorkEditions({
    required String key,
    required int limit,
    required int offset
  }) async {
    Uri url = Uri.parse('$baseUrl/works/$key/editions.json'
        '?limit=$limit&offset=$offset');
    try {
      http.Response response = await http.get(url);
      WorkEditions workEditions = WorkEditions.fromJson(jsonDecode(response.body));
      return workEditions;
    } catch (e) {
      return null;
    }
  }

  Future<Author?> getAuthor({
    required String key,
  }) async {
    Uri url = Uri.parse('$baseUrl/authors/$key.json');
    try {
      http.Response response = await http.get(url);
      Author author = Author.fromJson(jsonDecode(response.body));
      return author;
    } catch (e) {
      return null;
    }
  }
}