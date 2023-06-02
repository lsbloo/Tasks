import 'package:uuid/uuid.dart';

extension generateUUID on String {
  String generateUuid() {
    return Uuid().v1();
  }
}
