import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get content => text()();
  TextColumn get summary => text().nullable()();
}

@DriftDatabase(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- ADD THIS DELETE FUNCTION ---
  Future<int> deleteNote(Note note) {
    return (delete(notes)..where((t) => t.id.equals(note.id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    
    final dbFolder = await getTemporaryDirectory(); // Use Temp for the demo!
    final file = File(p.join(dbFolder.path, 'fresh_db.sqlite'));
    return NativeDatabase(file);
  });
}