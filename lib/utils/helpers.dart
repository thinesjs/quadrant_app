import 'package:quadrant_app/utils/enums/cart_type.dart';

bool isRecognitionNotification(String message) {
  return message.contains('recognized');
}

String getCartType(CartType cartType) {
  switch (cartType) {
    case CartType.ONLINE:
      return "online";
    case CartType.IN_STORE:
      return "in-store";
  }
}