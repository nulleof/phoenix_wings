import 'dart:convert';

class PhoenixMessage {
  String joinRef, ref, topic, event;
  Map payload;

  PhoenixMessage.fromString(String _message) {
    final message = json.decode(_message);

    this.joinRef = message['join_ref'];
    this.ref = message['ref'];
    this.topic = message['topic'];
    this.event = message['event'];
    this.payload = message['payload'];
  }

  PhoenixMessage(this.joinRef, this.ref, this.topic, this.event, this.payload);

  String toString() {
    return 'PhoenixMessage(topic=${topic}, join_ref=${joinRef}, ref=${ref}, event=${event})';
  }

  /// Convenience function for decoding received Phoenix messages
  static PhoenixMessage decode(rawPayload) {
    final decoded = json.decode(rawPayload);

    // actually no join_ref, it will be null
    return new PhoenixMessage(decoded['join_ref'], decoded['ref'],
        decoded['topic'], decoded['event'], decoded['payload']);
  }

  String toJSON() {
    // serilize to string, with map
    return json.encode({
      'join_ref': joinRef,
      'ref': ref,
      'topic': topic,
      'event': event,
      'payload': payload
    });
  }

  /// Constructor for a hearbeat message.
  PhoenixMessage.heartbeat(String pendingHeartbeatRef) {
    ref = pendingHeartbeatRef;
    payload = {};
    event = "heartbeat";
    topic = "phoenix"; // TODO protocal changed, update
  }
}
