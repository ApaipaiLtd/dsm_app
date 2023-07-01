import 'tables.dart';

extension TableServersExt on Server {
  String get url {
    return "${ssl ? 'https' : 'http'}://$domain:$port";
  }
}
