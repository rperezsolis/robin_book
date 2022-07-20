import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:robin_book/domain/models/work_search/work_search.dart';

class WorkSearchConverter extends TypeConverter<WorkSearch, String> {

  @override
  WorkSearch? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return WorkSearch.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(WorkSearch? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value.toJson());
  }

}