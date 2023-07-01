// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// ignore_for_file: type=lint
class $ServerGroupsTable extends ServerGroups
    with TableInfo<$ServerGroupsTable, ServerGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServerGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupNameMeta =
      const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String> groupName = GeneratedColumn<String>(
      'group_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, groupName, createTime];
  @override
  String get aliasedName => _alias ?? 'server_groups';
  @override
  String get actualTableName => 'server_groups';
  @override
  VerificationContext validateIntegrity(Insertable<ServerGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServerGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServerGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_name'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
    );
  }

  @override
  $ServerGroupsTable createAlias(String alias) {
    return $ServerGroupsTable(attachedDatabase, alias);
  }
}

class ServerGroup extends DataClass implements Insertable<ServerGroup> {
  final int id;
  final String groupName;
  final int createTime;
  const ServerGroup(
      {required this.id, required this.groupName, required this.createTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_name'] = Variable<String>(groupName);
    map['create_time'] = Variable<int>(createTime);
    return map;
  }

  ServerGroupsCompanion toCompanion(bool nullToAbsent) {
    return ServerGroupsCompanion(
      id: Value(id),
      groupName: Value(groupName),
      createTime: Value(createTime),
    );
  }

  factory ServerGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServerGroup(
      id: serializer.fromJson<int>(json['id']),
      groupName: serializer.fromJson<String>(json['groupName']),
      createTime: serializer.fromJson<int>(json['createTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupName': serializer.toJson<String>(groupName),
      'createTime': serializer.toJson<int>(createTime),
    };
  }

  ServerGroup copyWith({int? id, String? groupName, int? createTime}) =>
      ServerGroup(
        id: id ?? this.id,
        groupName: groupName ?? this.groupName,
        createTime: createTime ?? this.createTime,
      );
  @override
  String toString() {
    return (StringBuffer('ServerGroup(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupName, createTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServerGroup &&
          other.id == this.id &&
          other.groupName == this.groupName &&
          other.createTime == this.createTime);
}

class ServerGroupsCompanion extends UpdateCompanion<ServerGroup> {
  final Value<int> id;
  final Value<String> groupName;
  final Value<int> createTime;
  const ServerGroupsCompanion({
    this.id = const Value.absent(),
    this.groupName = const Value.absent(),
    this.createTime = const Value.absent(),
  });
  ServerGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String groupName,
    required int createTime,
  })  : groupName = Value(groupName),
        createTime = Value(createTime);
  static Insertable<ServerGroup> custom({
    Expression<int>? id,
    Expression<String>? groupName,
    Expression<int>? createTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupName != null) 'group_name': groupName,
      if (createTime != null) 'create_time': createTime,
    });
  }

  ServerGroupsCompanion copyWith(
      {Value<int>? id, Value<String>? groupName, Value<int>? createTime}) {
    return ServerGroupsCompanion(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServerGroupsCompanion(')
          ..write('id: $id, ')
          ..write('groupName: $groupName, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }
}

class $ServersTable extends Servers with TableInfo<$ServersTable, Server> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
      'group_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sslMeta = const VerificationMeta('ssl');
  @override
  late final GeneratedColumn<bool> ssl =
      GeneratedColumn<bool>('ssl', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("ssl" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _qcidMeta = const VerificationMeta('qcid');
  @override
  late final GeneratedColumn<String> qcid = GeneratedColumn<String>(
      'qcid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _domainMeta = const VerificationMeta('domain');
  @override
  late final GeneratedColumn<String> domain = GeneratedColumn<String>(
      'domain', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _portMeta = const VerificationMeta('port');
  @override
  late final GeneratedColumn<int> port = GeneratedColumn<int>(
      'port', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _checkSslMeta =
      const VerificationMeta('checkSsl');
  @override
  late final GeneratedColumn<bool> checkSsl =
      GeneratedColumn<bool>('check_ssl', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("check_ssl" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _macAddressMeta =
      const VerificationMeta('macAddress');
  @override
  late final GeneratedColumn<String> macAddress = GeneratedColumn<String>(
      'mac_address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hostnameMeta =
      const VerificationMeta('hostname');
  @override
  late final GeneratedColumn<String> hostname = GeneratedColumn<String>(
      'hostname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backgroundImageMeta =
      const VerificationMeta('backgroundImage');
  @override
  late final GeneratedColumn<String> backgroundImage = GeneratedColumn<String>(
      'background_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        groupId,
        ssl,
        qcid,
        domain,
        port,
        checkSsl,
        remark,
        macAddress,
        createTime,
        hostname,
        backgroundImage
      ];
  @override
  String get aliasedName => _alias ?? 'servers';
  @override
  String get actualTableName => 'servers';
  @override
  VerificationContext validateIntegrity(Insertable<Server> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('ssl')) {
      context.handle(
          _sslMeta, ssl.isAcceptableOrUnknown(data['ssl']!, _sslMeta));
    } else if (isInserting) {
      context.missing(_sslMeta);
    }
    if (data.containsKey('qcid')) {
      context.handle(
          _qcidMeta, qcid.isAcceptableOrUnknown(data['qcid']!, _qcidMeta));
    } else if (isInserting) {
      context.missing(_qcidMeta);
    }
    if (data.containsKey('domain')) {
      context.handle(_domainMeta,
          domain.isAcceptableOrUnknown(data['domain']!, _domainMeta));
    } else if (isInserting) {
      context.missing(_domainMeta);
    }
    if (data.containsKey('port')) {
      context.handle(
          _portMeta, port.isAcceptableOrUnknown(data['port']!, _portMeta));
    } else if (isInserting) {
      context.missing(_portMeta);
    }
    if (data.containsKey('check_ssl')) {
      context.handle(_checkSslMeta,
          checkSsl.isAcceptableOrUnknown(data['check_ssl']!, _checkSslMeta));
    } else if (isInserting) {
      context.missing(_checkSslMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    } else if (isInserting) {
      context.missing(_remarkMeta);
    }
    if (data.containsKey('mac_address')) {
      context.handle(
          _macAddressMeta,
          macAddress.isAcceptableOrUnknown(
              data['mac_address']!, _macAddressMeta));
    } else if (isInserting) {
      context.missing(_macAddressMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('hostname')) {
      context.handle(_hostnameMeta,
          hostname.isAcceptableOrUnknown(data['hostname']!, _hostnameMeta));
    }
    if (data.containsKey('background_image')) {
      context.handle(
          _backgroundImageMeta,
          backgroundImage.isAcceptableOrUnknown(
              data['background_image']!, _backgroundImageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Server map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Server(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_id'])!,
      ssl: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ssl'])!,
      qcid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}qcid'])!,
      domain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}domain'])!,
      port: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}port'])!,
      checkSsl: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}check_ssl'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark'])!,
      macAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mac_address'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      hostname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hostname']),
      backgroundImage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}background_image']),
    );
  }

  @override
  $ServersTable createAlias(String alias) {
    return $ServersTable(attachedDatabase, alias);
  }
}

class Server extends DataClass implements Insertable<Server> {
  final int id;
  final int groupId;
  final bool ssl;
  final String qcid;
  final String domain;
  final int port;
  final bool checkSsl;
  final String remark;
  final String macAddress;
  final int createTime;
  final String? hostname;
  final String? backgroundImage;
  const Server(
      {required this.id,
      required this.groupId,
      required this.ssl,
      required this.qcid,
      required this.domain,
      required this.port,
      required this.checkSsl,
      required this.remark,
      required this.macAddress,
      required this.createTime,
      this.hostname,
      this.backgroundImage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['ssl'] = Variable<bool>(ssl);
    map['qcid'] = Variable<String>(qcid);
    map['domain'] = Variable<String>(domain);
    map['port'] = Variable<int>(port);
    map['check_ssl'] = Variable<bool>(checkSsl);
    map['remark'] = Variable<String>(remark);
    map['mac_address'] = Variable<String>(macAddress);
    map['create_time'] = Variable<int>(createTime);
    if (!nullToAbsent || hostname != null) {
      map['hostname'] = Variable<String>(hostname);
    }
    if (!nullToAbsent || backgroundImage != null) {
      map['background_image'] = Variable<String>(backgroundImage);
    }
    return map;
  }

  ServersCompanion toCompanion(bool nullToAbsent) {
    return ServersCompanion(
      id: Value(id),
      groupId: Value(groupId),
      ssl: Value(ssl),
      qcid: Value(qcid),
      domain: Value(domain),
      port: Value(port),
      checkSsl: Value(checkSsl),
      remark: Value(remark),
      macAddress: Value(macAddress),
      createTime: Value(createTime),
      hostname: hostname == null && nullToAbsent
          ? const Value.absent()
          : Value(hostname),
      backgroundImage: backgroundImage == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundImage),
    );
  }

  factory Server.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Server(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      ssl: serializer.fromJson<bool>(json['ssl']),
      qcid: serializer.fromJson<String>(json['qcid']),
      domain: serializer.fromJson<String>(json['domain']),
      port: serializer.fromJson<int>(json['port']),
      checkSsl: serializer.fromJson<bool>(json['checkSsl']),
      remark: serializer.fromJson<String>(json['remark']),
      macAddress: serializer.fromJson<String>(json['macAddress']),
      createTime: serializer.fromJson<int>(json['createTime']),
      hostname: serializer.fromJson<String?>(json['hostname']),
      backgroundImage: serializer.fromJson<String?>(json['backgroundImage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'ssl': serializer.toJson<bool>(ssl),
      'qcid': serializer.toJson<String>(qcid),
      'domain': serializer.toJson<String>(domain),
      'port': serializer.toJson<int>(port),
      'checkSsl': serializer.toJson<bool>(checkSsl),
      'remark': serializer.toJson<String>(remark),
      'macAddress': serializer.toJson<String>(macAddress),
      'createTime': serializer.toJson<int>(createTime),
      'hostname': serializer.toJson<String?>(hostname),
      'backgroundImage': serializer.toJson<String?>(backgroundImage),
    };
  }

  Server copyWith(
          {int? id,
          int? groupId,
          bool? ssl,
          String? qcid,
          String? domain,
          int? port,
          bool? checkSsl,
          String? remark,
          String? macAddress,
          int? createTime,
          Value<String?> hostname = const Value.absent(),
          Value<String?> backgroundImage = const Value.absent()}) =>
      Server(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        ssl: ssl ?? this.ssl,
        qcid: qcid ?? this.qcid,
        domain: domain ?? this.domain,
        port: port ?? this.port,
        checkSsl: checkSsl ?? this.checkSsl,
        remark: remark ?? this.remark,
        macAddress: macAddress ?? this.macAddress,
        createTime: createTime ?? this.createTime,
        hostname: hostname.present ? hostname.value : this.hostname,
        backgroundImage: backgroundImage.present
            ? backgroundImage.value
            : this.backgroundImage,
      );
  @override
  String toString() {
    return (StringBuffer('Server(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('ssl: $ssl, ')
          ..write('qcid: $qcid, ')
          ..write('domain: $domain, ')
          ..write('port: $port, ')
          ..write('checkSsl: $checkSsl, ')
          ..write('remark: $remark, ')
          ..write('macAddress: $macAddress, ')
          ..write('createTime: $createTime, ')
          ..write('hostname: $hostname, ')
          ..write('backgroundImage: $backgroundImage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, ssl, qcid, domain, port,
      checkSsl, remark, macAddress, createTime, hostname, backgroundImage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Server &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.ssl == this.ssl &&
          other.qcid == this.qcid &&
          other.domain == this.domain &&
          other.port == this.port &&
          other.checkSsl == this.checkSsl &&
          other.remark == this.remark &&
          other.macAddress == this.macAddress &&
          other.createTime == this.createTime &&
          other.hostname == this.hostname &&
          other.backgroundImage == this.backgroundImage);
}

class ServersCompanion extends UpdateCompanion<Server> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<bool> ssl;
  final Value<String> qcid;
  final Value<String> domain;
  final Value<int> port;
  final Value<bool> checkSsl;
  final Value<String> remark;
  final Value<String> macAddress;
  final Value<int> createTime;
  final Value<String?> hostname;
  final Value<String?> backgroundImage;
  const ServersCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.ssl = const Value.absent(),
    this.qcid = const Value.absent(),
    this.domain = const Value.absent(),
    this.port = const Value.absent(),
    this.checkSsl = const Value.absent(),
    this.remark = const Value.absent(),
    this.macAddress = const Value.absent(),
    this.createTime = const Value.absent(),
    this.hostname = const Value.absent(),
    this.backgroundImage = const Value.absent(),
  });
  ServersCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required bool ssl,
    required String qcid,
    required String domain,
    required int port,
    required bool checkSsl,
    required String remark,
    required String macAddress,
    required int createTime,
    this.hostname = const Value.absent(),
    this.backgroundImage = const Value.absent(),
  })  : groupId = Value(groupId),
        ssl = Value(ssl),
        qcid = Value(qcid),
        domain = Value(domain),
        port = Value(port),
        checkSsl = Value(checkSsl),
        remark = Value(remark),
        macAddress = Value(macAddress),
        createTime = Value(createTime);
  static Insertable<Server> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<bool>? ssl,
    Expression<String>? qcid,
    Expression<String>? domain,
    Expression<int>? port,
    Expression<bool>? checkSsl,
    Expression<String>? remark,
    Expression<String>? macAddress,
    Expression<int>? createTime,
    Expression<String>? hostname,
    Expression<String>? backgroundImage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (ssl != null) 'ssl': ssl,
      if (qcid != null) 'qcid': qcid,
      if (domain != null) 'domain': domain,
      if (port != null) 'port': port,
      if (checkSsl != null) 'check_ssl': checkSsl,
      if (remark != null) 'remark': remark,
      if (macAddress != null) 'mac_address': macAddress,
      if (createTime != null) 'create_time': createTime,
      if (hostname != null) 'hostname': hostname,
      if (backgroundImage != null) 'background_image': backgroundImage,
    });
  }

  ServersCompanion copyWith(
      {Value<int>? id,
      Value<int>? groupId,
      Value<bool>? ssl,
      Value<String>? qcid,
      Value<String>? domain,
      Value<int>? port,
      Value<bool>? checkSsl,
      Value<String>? remark,
      Value<String>? macAddress,
      Value<int>? createTime,
      Value<String?>? hostname,
      Value<String?>? backgroundImage}) {
    return ServersCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      ssl: ssl ?? this.ssl,
      qcid: qcid ?? this.qcid,
      domain: domain ?? this.domain,
      port: port ?? this.port,
      checkSsl: checkSsl ?? this.checkSsl,
      remark: remark ?? this.remark,
      macAddress: macAddress ?? this.macAddress,
      createTime: createTime ?? this.createTime,
      hostname: hostname ?? this.hostname,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (ssl.present) {
      map['ssl'] = Variable<bool>(ssl.value);
    }
    if (qcid.present) {
      map['qcid'] = Variable<String>(qcid.value);
    }
    if (domain.present) {
      map['domain'] = Variable<String>(domain.value);
    }
    if (port.present) {
      map['port'] = Variable<int>(port.value);
    }
    if (checkSsl.present) {
      map['check_ssl'] = Variable<bool>(checkSsl.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (macAddress.present) {
      map['mac_address'] = Variable<String>(macAddress.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (hostname.present) {
      map['hostname'] = Variable<String>(hostname.value);
    }
    if (backgroundImage.present) {
      map['background_image'] = Variable<String>(backgroundImage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServersCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('ssl: $ssl, ')
          ..write('qcid: $qcid, ')
          ..write('domain: $domain, ')
          ..write('port: $port, ')
          ..write('checkSsl: $checkSsl, ')
          ..write('remark: $remark, ')
          ..write('macAddress: $macAddress, ')
          ..write('createTime: $createTime, ')
          ..write('hostname: $hostname, ')
          ..write('backgroundImage: $backgroundImage')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _serverIdMeta =
      const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<int> serverId = GeneratedColumn<int>(
      'server_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _accountMeta =
      const VerificationMeta('account');
  @override
  late final GeneratedColumn<String> account = GeneratedColumn<String>(
      'account', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordMeta =
      const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
      'remark', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<int> createTime = GeneratedColumn<int>(
      'create_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastLoginTimeMeta =
      const VerificationMeta('lastLoginTime');
  @override
  late final GeneratedColumn<int> lastLoginTime = GeneratedColumn<int>(
      'last_login_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault =
      GeneratedColumn<bool>('is_default', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_default" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sidMeta = const VerificationMeta('sid');
  @override
  late final GeneratedColumn<String> sid = GeneratedColumn<String>(
      'sid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ikMessageMeta =
      const VerificationMeta('ikMessage');
  @override
  late final GeneratedColumn<String> ikMessage = GeneratedColumn<String>(
      'ik_message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _synoTokenMeta =
      const VerificationMeta('synoToken');
  @override
  late final GeneratedColumn<String> synoToken = GeneratedColumn<String>(
      'syno_token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        serverId,
        account,
        password,
        remark,
        createTime,
        lastLoginTime,
        isDefault,
        deviceId,
        sid,
        ikMessage,
        synoToken
      ];
  @override
  String get aliasedName => _alias ?? 'accounts';
  @override
  String get actualTableName => 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<Account> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    } else if (isInserting) {
      context.missing(_serverIdMeta);
    }
    if (data.containsKey('account')) {
      context.handle(_accountMeta,
          account.isAcceptableOrUnknown(data['account']!, _accountMeta));
    } else if (isInserting) {
      context.missing(_accountMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('remark')) {
      context.handle(_remarkMeta,
          remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta));
    } else if (isInserting) {
      context.missing(_remarkMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    } else if (isInserting) {
      context.missing(_createTimeMeta);
    }
    if (data.containsKey('last_login_time')) {
      context.handle(
          _lastLoginTimeMeta,
          lastLoginTime.isAcceptableOrUnknown(
              data['last_login_time']!, _lastLoginTimeMeta));
    } else if (isInserting) {
      context.missing(_lastLoginTimeMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    } else if (isInserting) {
      context.missing(_isDefaultMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('sid')) {
      context.handle(
          _sidMeta, sid.isAcceptableOrUnknown(data['sid']!, _sidMeta));
    } else if (isInserting) {
      context.missing(_sidMeta);
    }
    if (data.containsKey('ik_message')) {
      context.handle(_ikMessageMeta,
          ikMessage.isAcceptableOrUnknown(data['ik_message']!, _ikMessageMeta));
    } else if (isInserting) {
      context.missing(_ikMessageMeta);
    }
    if (data.containsKey('syno_token')) {
      context.handle(_synoTokenMeta,
          synoToken.isAcceptableOrUnknown(data['syno_token']!, _synoTokenMeta));
    } else if (isInserting) {
      context.missing(_synoTokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      serverId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}server_id'])!,
      account: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account'])!,
      password: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      remark: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remark'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}create_time'])!,
      lastLoginTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_login_time'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      sid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sid'])!,
      ikMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ik_message'])!,
      synoToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}syno_token'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final int serverId;
  final String account;
  final String password;
  final String remark;
  final int createTime;
  final int lastLoginTime;
  final bool isDefault;
  final String deviceId;
  final String sid;
  final String ikMessage;
  final String synoToken;
  const Account(
      {required this.id,
      required this.serverId,
      required this.account,
      required this.password,
      required this.remark,
      required this.createTime,
      required this.lastLoginTime,
      required this.isDefault,
      required this.deviceId,
      required this.sid,
      required this.ikMessage,
      required this.synoToken});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_id'] = Variable<int>(serverId);
    map['account'] = Variable<String>(account);
    map['password'] = Variable<String>(password);
    map['remark'] = Variable<String>(remark);
    map['create_time'] = Variable<int>(createTime);
    map['last_login_time'] = Variable<int>(lastLoginTime);
    map['is_default'] = Variable<bool>(isDefault);
    map['device_id'] = Variable<String>(deviceId);
    map['sid'] = Variable<String>(sid);
    map['ik_message'] = Variable<String>(ikMessage);
    map['syno_token'] = Variable<String>(synoToken);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      serverId: Value(serverId),
      account: Value(account),
      password: Value(password),
      remark: Value(remark),
      createTime: Value(createTime),
      lastLoginTime: Value(lastLoginTime),
      isDefault: Value(isDefault),
      deviceId: Value(deviceId),
      sid: Value(sid),
      ikMessage: Value(ikMessage),
      synoToken: Value(synoToken),
    );
  }

  factory Account.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<int>(json['serverId']),
      account: serializer.fromJson<String>(json['account']),
      password: serializer.fromJson<String>(json['password']),
      remark: serializer.fromJson<String>(json['remark']),
      createTime: serializer.fromJson<int>(json['createTime']),
      lastLoginTime: serializer.fromJson<int>(json['lastLoginTime']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      sid: serializer.fromJson<String>(json['sid']),
      ikMessage: serializer.fromJson<String>(json['ikMessage']),
      synoToken: serializer.fromJson<String>(json['synoToken']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<int>(serverId),
      'account': serializer.toJson<String>(account),
      'password': serializer.toJson<String>(password),
      'remark': serializer.toJson<String>(remark),
      'createTime': serializer.toJson<int>(createTime),
      'lastLoginTime': serializer.toJson<int>(lastLoginTime),
      'isDefault': serializer.toJson<bool>(isDefault),
      'deviceId': serializer.toJson<String>(deviceId),
      'sid': serializer.toJson<String>(sid),
      'ikMessage': serializer.toJson<String>(ikMessage),
      'synoToken': serializer.toJson<String>(synoToken),
    };
  }

  Account copyWith(
          {int? id,
          int? serverId,
          String? account,
          String? password,
          String? remark,
          int? createTime,
          int? lastLoginTime,
          bool? isDefault,
          String? deviceId,
          String? sid,
          String? ikMessage,
          String? synoToken}) =>
      Account(
        id: id ?? this.id,
        serverId: serverId ?? this.serverId,
        account: account ?? this.account,
        password: password ?? this.password,
        remark: remark ?? this.remark,
        createTime: createTime ?? this.createTime,
        lastLoginTime: lastLoginTime ?? this.lastLoginTime,
        isDefault: isDefault ?? this.isDefault,
        deviceId: deviceId ?? this.deviceId,
        sid: sid ?? this.sid,
        ikMessage: ikMessage ?? this.ikMessage,
        synoToken: synoToken ?? this.synoToken,
      );
  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('account: $account, ')
          ..write('password: $password, ')
          ..write('remark: $remark, ')
          ..write('createTime: $createTime, ')
          ..write('lastLoginTime: $lastLoginTime, ')
          ..write('isDefault: $isDefault, ')
          ..write('deviceId: $deviceId, ')
          ..write('sid: $sid, ')
          ..write('ikMessage: $ikMessage, ')
          ..write('synoToken: $synoToken')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      serverId,
      account,
      password,
      remark,
      createTime,
      lastLoginTime,
      isDefault,
      deviceId,
      sid,
      ikMessage,
      synoToken);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.account == this.account &&
          other.password == this.password &&
          other.remark == this.remark &&
          other.createTime == this.createTime &&
          other.lastLoginTime == this.lastLoginTime &&
          other.isDefault == this.isDefault &&
          other.deviceId == this.deviceId &&
          other.sid == this.sid &&
          other.ikMessage == this.ikMessage &&
          other.synoToken == this.synoToken);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<int> serverId;
  final Value<String> account;
  final Value<String> password;
  final Value<String> remark;
  final Value<int> createTime;
  final Value<int> lastLoginTime;
  final Value<bool> isDefault;
  final Value<String> deviceId;
  final Value<String> sid;
  final Value<String> ikMessage;
  final Value<String> synoToken;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.account = const Value.absent(),
    this.password = const Value.absent(),
    this.remark = const Value.absent(),
    this.createTime = const Value.absent(),
    this.lastLoginTime = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.sid = const Value.absent(),
    this.ikMessage = const Value.absent(),
    this.synoToken = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required int serverId,
    required String account,
    required String password,
    required String remark,
    required int createTime,
    required int lastLoginTime,
    required bool isDefault,
    required String deviceId,
    required String sid,
    required String ikMessage,
    required String synoToken,
  })  : serverId = Value(serverId),
        account = Value(account),
        password = Value(password),
        remark = Value(remark),
        createTime = Value(createTime),
        lastLoginTime = Value(lastLoginTime),
        isDefault = Value(isDefault),
        deviceId = Value(deviceId),
        sid = Value(sid),
        ikMessage = Value(ikMessage),
        synoToken = Value(synoToken);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<int>? serverId,
    Expression<String>? account,
    Expression<String>? password,
    Expression<String>? remark,
    Expression<int>? createTime,
    Expression<int>? lastLoginTime,
    Expression<bool>? isDefault,
    Expression<String>? deviceId,
    Expression<String>? sid,
    Expression<String>? ikMessage,
    Expression<String>? synoToken,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (account != null) 'account': account,
      if (password != null) 'password': password,
      if (remark != null) 'remark': remark,
      if (createTime != null) 'create_time': createTime,
      if (lastLoginTime != null) 'last_login_time': lastLoginTime,
      if (isDefault != null) 'is_default': isDefault,
      if (deviceId != null) 'device_id': deviceId,
      if (sid != null) 'sid': sid,
      if (ikMessage != null) 'ik_message': ikMessage,
      if (synoToken != null) 'syno_token': synoToken,
    });
  }

  AccountsCompanion copyWith(
      {Value<int>? id,
      Value<int>? serverId,
      Value<String>? account,
      Value<String>? password,
      Value<String>? remark,
      Value<int>? createTime,
      Value<int>? lastLoginTime,
      Value<bool>? isDefault,
      Value<String>? deviceId,
      Value<String>? sid,
      Value<String>? ikMessage,
      Value<String>? synoToken}) {
    return AccountsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      account: account ?? this.account,
      password: password ?? this.password,
      remark: remark ?? this.remark,
      createTime: createTime ?? this.createTime,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      isDefault: isDefault ?? this.isDefault,
      deviceId: deviceId ?? this.deviceId,
      sid: sid ?? this.sid,
      ikMessage: ikMessage ?? this.ikMessage,
      synoToken: synoToken ?? this.synoToken,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<int>(serverId.value);
    }
    if (account.present) {
      map['account'] = Variable<String>(account.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<int>(createTime.value);
    }
    if (lastLoginTime.present) {
      map['last_login_time'] = Variable<int>(lastLoginTime.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (sid.present) {
      map['sid'] = Variable<String>(sid.value);
    }
    if (ikMessage.present) {
      map['ik_message'] = Variable<String>(ikMessage.value);
    }
    if (synoToken.present) {
      map['syno_token'] = Variable<String>(synoToken.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('account: $account, ')
          ..write('password: $password, ')
          ..write('remark: $remark, ')
          ..write('createTime: $createTime, ')
          ..write('lastLoginTime: $lastLoginTime, ')
          ..write('isDefault: $isDefault, ')
          ..write('deviceId: $deviceId, ')
          ..write('sid: $sid, ')
          ..write('ikMessage: $ikMessage, ')
          ..write('synoToken: $synoToken')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $ServerGroupsTable serverGroups = $ServerGroupsTable(this);
  late final $ServersTable servers = $ServersTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [serverGroups, servers, accounts];
}
