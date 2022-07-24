import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WashDatabase {
  static final WashDatabase instance = WashDatabase._init();
  static Database? _database;
  WashDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('rental.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE country (
    id   INTEGER NOT NULL,
    name VARCHAR2(50) NOT NULL
);

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( id );

CREATE TABLE item (
    id             INTEGER NOT NULL,
    item_name      VARCHAR2(50) NOT NULL,
    description    VARCHAR2(50) NOT NULL,
    available      BLOB NOT NULL,
    price_per_unit NUMBER(8, 2) NOT NULL,
    fee            NUMBER(8, 2),
    unit_id        INTEGER NOT NULL,
    item_type_id   INTEGER NOT NULL
);

ALTER TABLE item ADD CONSTRAINT item_pk PRIMARY KEY ( id );

CREATE TABLE item_leased (
    id              INTEGER NOT NULL,
    time_from       TIMESTAMP(8) WITH TIME ZONE NOT NULL,
    time_to         TIMESTAMP(8) WITH TIME ZONE NOT NULL,
    price_per_unit  NUMBER(8, 2) NOT NULL,
    discount        NUMBER(8, 2),
    fee             NUMBER(8, 2),
    price_total     NUMBER(8, 2) NOT NULL,
    user_account_id INTEGER NOT NULL,
    item_id         INTEGER NOT NULL,
    unit_id         INTEGER NOT NULL
);

ALTER TABLE item_leased ADD CONSTRAINT item_leased_pk PRIMARY KEY ( id );

CREATE TABLE item_type (
    id        INTEGER NOT NULL,
    type_name VARCHAR2(50) NOT NULL
);

ALTER TABLE item_type ADD CONSTRAINT item_type_pk PRIMARY KEY ( id );

CREATE TABLE location (
    id          INTEGER NOT NULL,
    postal_code INTEGER NOT NULL,
    name        VARCHAR2(50) NOT NULL,
    country_id  INTEGER NOT NULL
);

ALTER TABLE location ADD CONSTRAINT location_pk PRIMARY KEY ( id );

CREATE TABLE unit (
    id        INTEGER NOT NULL,
    unit_name VARCHAR2(50) NOT NULL
);

ALTER TABLE unit ADD CONSTRAINT unit_pk PRIMARY KEY ( id );

CREATE TABLE user_account (
    id          INTEGER NOT NULL,
    username    VARCHAR2(50) NOT NULL,
    email       VARCHAR2(50) NOT NULL,
    password    VARCHAR2(50) NOT NULL,
    no_hp       INTEGER NOT NULL,
    location    VARCHAR2(50),
    location_id INTEGER NOT NULL
);

ALTER TABLE user_account ADD CONSTRAINT user_account_pk PRIMARY KEY ( id );

ALTER TABLE item
    ADD CONSTRAINT item_item_type_fk FOREIGN KEY ( item_type_id )
        REFERENCES item_type ( id );

ALTER TABLE item_leased
    ADD CONSTRAINT item_leased_item_fk FOREIGN KEY ( item_id )
        REFERENCES item ( id );

ALTER TABLE item_leased
    ADD CONSTRAINT item_leased_unit_fk FOREIGN KEY ( unit_id )
        REFERENCES unit ( id );

ALTER TABLE item_leased
    ADD CONSTRAINT item_leased_user_account_fk FOREIGN KEY ( user_account_id )
        REFERENCES user_account ( id );

ALTER TABLE item
    ADD CONSTRAINT item_unit_fk FOREIGN KEY ( unit_id )
        REFERENCES unit ( id );

ALTER TABLE location
    ADD CONSTRAINT location_country_fk FOREIGN KEY ( country_id )
        REFERENCES country ( id );

ALTER TABLE user_account
    ADD CONSTRAINT user_account_location_fk FOREIGN KEY ( location_id )
        REFERENCES location ( id );
    ''');
  }

  Future _closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
