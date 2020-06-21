import 'package:board_game_app/DataTypes/BoardGame.dart';

class NewRelease extends BoardGame{
  String versionId;
  String versionName;
  String releaseDate;
  String numwish;

  NewRelease(
    {id, 
    name, 
    imageUrl, 
    fullImageUrl, 
    yearPublished, 
    minPlayers, 
    maxPlayers,
    minPlaytime,
    maxPlaytime,
    age,
    description,
    designer,
    boardGamePublisher,
    mechanic, 
    rating,
    weight,
    ranks,
    recPlayers,
    recPlaytime,
    videos,
    this.versionId, 
    this.versionName, 
    this.releaseDate, 
    this.numwish}
  ) : super.fullDetails(
    id, 
    name, 
    imageUrl, 
    fullImageUrl, 
    yearPublished, 
    minPlayers, 
    maxPlayers,
    minPlaytime,
    maxPlaytime,
    age,
    description,
    designer,
    boardGamePublisher,
    mechanic, 
    rating,
    weight,
    ranks,
    recPlayers,
    recPlaytime,
    videos
  );
}