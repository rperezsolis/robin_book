import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:robin_book/domain/models/work/work.dart';

class WorkConverter extends TypeConverter<Work, String> {

  @override
  Work? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    return Work.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String? mapToSql(Work? value) {
    if (value == null) {
      return null;
    }
    return jsonEncode(value.toJson());
  }
}