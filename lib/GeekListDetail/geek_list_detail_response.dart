import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:board_game_app/GeekListDetail/geek_list_detail_bloc.dart';
import 'package:board_game_app/HomeScreen/GeekList/geek_list_repository.dart';
import 'package:xml/xml.dart';

class GeekListDetailResponse {
  int totalResults;
  GeekList results;
  
  GeekListDetailResponse.fromXml(XmlDocument doc) {
    results = new GeekList.fromXml(doc);
  }
}