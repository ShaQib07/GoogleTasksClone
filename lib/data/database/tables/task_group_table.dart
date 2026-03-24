import 'package:drift/drift.dart';

class TaskGroupTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tabName => text()();
}
