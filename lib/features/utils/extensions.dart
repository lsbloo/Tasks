import 'package:uuid/uuid.dart';

extension generateUUID on String {
  String generateUuid() {
    return const Uuid().v1();
  }
}
