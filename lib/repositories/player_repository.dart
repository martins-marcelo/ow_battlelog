

import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:ow_battlenet/models/competitive_status_model.dart';
import 'package:ow_battlenet/models/endorsement.dart';

import 'package:ow_battlenet/models/player_model.dart';
import 'package:ow_battlenet/models/player_summary_model.dart';

class PlayerRepository {

  Future<List<PlayerSummaryModel>> searchPlayersByUsername(String username) async {
    final queryParams = {
      'name': username
    };
    var url = Uri.http(_getUrl(), '/players', queryParams);
    var response = await http.get(url);
    if(response.statusCode == 200) {
      var decodedMap = convert.jsonDecode(response.body);
      var decoded = decodedMap['results'] as List;
      List<PlayerSummaryModel> lista = decoded.map((e) => PlayerSummaryModel.fromJson(e)).toList();
      return lista;
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return List.of([]);
  }

  Future<PlayerModel> searchAllDataFromPlayer(String playerId) async {
    var url = Uri.http(_getUrl(), '/players/$playerId');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response);
      var decodedMap = convert.jsonDecode(response.body);
      var decoded = decodedMap['summary'];
      print(decoded);
      PlayerModel item = PlayerModel.fromJson(decoded);
      return item;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return PlayerModel('', '', '', '', Endorsement(), CompetitiveStatusModel(), 0);
  }

  Future<Uint8List> searchImage(String imageUrl) async {
    var url = Uri.parse(imageUrl);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return Uint8List(0);
  }

  String _getUrl() {
    return 'overfast-api.tekrop.fr';
  }
}