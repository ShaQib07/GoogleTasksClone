import 'package:drift/drift.dart';
import 'package:google_tasks_clone/data/database/tables/tab_table.dart';

class TaskTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get tabId => integer().references(TaskTabTable, #id)();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dateAndTime => dateTime().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  TextColumn get reminder => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
