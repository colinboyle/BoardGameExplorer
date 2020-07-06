import 'dart:async';

import 'package:board_game_app/DataTypes/Thread.dart';

import 'package:board_game_app/ThreadDetail/thread_detail_repository.dart';
import 'package:board_game_app/utils/api_exceptions.dart';
import 'package:board_game_app/utils/api_response.dart';

class ThreadDetailBloc {
  ThreadDetailRepository _ThreadDetailRepository;
  StreamController _ThreadDetailController;

  StreamSink<ApiResponse<Thread>> get ThreadDetailSink => _ThreadDetailController.sink;
  Stream<ApiResponse<Thread>> get ThreadDetailStream => _ThreadDetailController.stream;

  ThreadDetailBloc() { 
    _ThreadDetailController = StreamController<ApiResponse<Thread>>();
    _ThreadDetailRepository = ThreadDetailRepository();
  }

 fetchThread(String geekListId) async {
    ThreadDetailSink.add(ApiResponse.loading('Fetching geek list detail'));
    try {
      Thread threadData = await _ThreadDetailRepository.fetchThread(geekListId);

      ThreadDetailSink.add(ApiResponse.completed(threadData));
    } catch (e) {
      print(e);
      ThreadDetailSink.add(ApiResponse.error(e.toString()));
    }
  }
  
  dispose() {
    _ThreadDetailController?.close();
  }
}