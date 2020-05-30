import 'dart:convert';

//import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/MarketOffers.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';

class MarketOffersResponse {
  //int totalResults;
  MarketOffers result;

  MarketOffersResponse.fromJSON(response){
    //print('Response from GI response');
    //print(response);
    result = new MarketOffers.fromJson(json.decode(response));
  }

}