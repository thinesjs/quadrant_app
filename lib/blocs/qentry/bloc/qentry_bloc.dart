import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/repositories/UserRepository/user_repository.dart';
import 'package:quadrant_app/utils/helpers/cache/cache_manager.dart';
import 'package:quadrant_app/utils/helpers/network/dio_manager.dart';

part 'qentry_event.dart';
part 'qentry_state.dart';

class QentryBloc extends Bloc<QentryEvent, QentryState> {
  QentryBloc() : super(QentryInitial()) {
    on<WebSocketMessageReceived>((event, emit) async {
      log("checking if received data matches user", name: "Q-EntryRepository");
      UserRepository userRepository = UserRepository(DioManager.instance);
      User? user = await userRepository.getUser();
      String userId = event.data['userId'];
      if (user!.id == userId) {
        log("user in store: $userId", name: "Q-EntryRepository");
        setQentryState(userId);
        emit(QentryVerified());
      }
    });
  }

  Future<void> setQentryState(String? userId) async {
    if(userId != null){
      await CacheManager.setString("qentry_state", userId);
    }else{
      if(await CacheManager.containsKey("qentry_state")){
        await CacheManager.remove("qentry_state");
      }
    }
  }
}