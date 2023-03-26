class Message {
  String sender;
  String content;
  Message(this.sender, this.content);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      json['sender'],
      json['content'],
    );
  }
}