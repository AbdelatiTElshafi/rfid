import '../database.dart';

class CamerasTable extends SupabaseTable<CamerasRow> {
  @override
  String get tableName => 'cameras';

  @override
  CamerasRow createRow(Map<String, dynamic> data) => CamerasRow(data);
}

class CamerasRow extends SupabaseDataRow {
  CamerasRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CamerasTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get camName => getField<String>('cam_name')!;
  set camName(String value) => setField<String>('cam_name', value);

  String get camId => getField<String>('cam_id')!;
  set camId(String value) => setField<String>('cam_id', value);

  String? get serverRemoteIp => getField<String>('server_remote_ip');
  set serverRemoteIp(String? value) =>
      setField<String>('server_remote_ip', value);

  String? get serverLocalIp => getField<String>('server_local_ip');
  set serverLocalIp(String? value) =>
      setField<String>('server_local_ip', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
