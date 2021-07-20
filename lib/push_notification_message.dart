class PushNotificationMessage {
  final String title;
  final String body;
  PushNotificationMessage({
    required this.title,
    required this.body,
  });

  @override
  String toString() {
    return "TITLE: $title \nBODY: $body";
  }
}
