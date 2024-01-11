abstract class ClipboardHandler {
  Future<String?> readText();
  Future writeText(String text);
}
