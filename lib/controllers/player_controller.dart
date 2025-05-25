import 'package:flutter/material.dart';
import 'package:ow_battlenet/models/player_model.dart';
import 'package:ow_battlenet/repositories/player_repository.dart';

class PlayerController {
  final PlayerRepository _playerRepository;

  PlayerController(this._playerRepository);

  late ValueNotifier<PlayerModel> playerModel;

  buscarPlayer(String name) async {
    if(name.contains('-')) {
      return _playerRepository.searchAllDataFromPlayer(name);
    }
    return _playerRepository.searchPlayersByUsername(name);
  }

  buscarImagem(String url) async {
    return await _playerRepository.searchImage(url);
  }
}