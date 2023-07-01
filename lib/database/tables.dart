import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:dsm_app/utils/db_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'tables.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class ServerGroups extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get groupName => text()();
  IntColumn get createTime => integer()();
}

class Servers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get groupId => integer()();
  BoolColumn get ssl => boolean()();
  TextColumn get qcid => text()();
  TextColumn get domain => text()();
  IntColumn get port => integer()();
  BoolColumn get checkSsl => boolean()();
  TextColumn get remark => text()();
  TextColumn get macAddress => text()();
  IntColumn get createTime => integer()();
  TextColumn get hostname => text().nullable()();
  TextColumn get backgroundImage => text().nullable()();
}

class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get serverId => integer()();
  TextColumn get account => text()();
  TextColumn get password => text()();
  TextColumn get remark => text()();
  IntColumn get createTime => integer()();
  IntColumn get lastLoginTime => integer()();
  BoolColumn get isDefault => boolean()();
  TextColumn get deviceId => text()();
  TextColumn get sid => text()();
  TextColumn get ikMessage => text()();
  TextColumn get synoToken => text()();
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [ServerGroups, Servers, Accounts])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator m, int from, int to) async {
        // if (from < 2) {
        //   // we added the dueDate property in the change from version 1 to
        //   // version 2
        //   await m.addColumn(todos, todos.dueDate);
        // }
      },
    );
  }

  Future updateServer(Server server) {
    return update(servers).replace(server);
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
