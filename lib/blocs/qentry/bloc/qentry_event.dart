part of 'qentry_bloc.dart';

abstract class QentryEvent {
  const QentryEvent();
}


class WebSocketMessageReceived extends QentryEvent {
  final dynamic data;

  WebSocketMessageReceived(this.data);
}