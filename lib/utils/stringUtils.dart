import '../globals.dart' as global;

bool ifEmptyOrNull(String text) {
  if (text == null || text.isEmpty) {
    return true;
  }
  return false;
}
