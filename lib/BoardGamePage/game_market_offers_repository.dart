//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/BoardGamePage/game_market_offers_response.dart';
//import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/MarketOffers.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
//import 'package:board_game_app/BoardGamePage/board_game_response.dart';

class MarketOffersRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<MarketOffers> fetchMarketOffers(String gameId) async {
    final url = 'geekmarket/products?ajax=1&nosession=1&objectid=$gameId&objecttype=thing&pageid=1&showcount=5&stock=instock';
    final response = await _helper.getJSON(url);
    return MarketOffersResponse.fromJSON(response).result;//response).result;
  }
}