import 'package:drift/drift.dart';

class TaskTabTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tabName => text()();
}
