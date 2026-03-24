import 'package:drift/drift.dart';
import 'package:google_tasks_clone/data/database/tables/task_group_table.dart';

class TaskTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get taskGroupId => integer().references(TaskGroupTable, #id)();
  IntColumn get parentTaskId => integer().nullable()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get dateAndTime => dateTime().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSubtask => boolean().withDefault(const Constant(false))();
}
