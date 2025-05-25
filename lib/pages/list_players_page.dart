import 'package:flutter/material.dart';
import 'package:ow_battlenet/controllers/player_controller.dart';
import 'package:ow_battlenet/models/player_summary_model.dart';
import 'package:ow_battlenet/repositories/player_repository.dart';

class ListPlayers extends StatefulWidget {
  const ListPlayers({super.key});

  @override
  State<ListPlayers> createState() => _ListPlayersState();
}

class _ListPlayersState extends State<ListPlayers> {
  final PlayerController _playerController = PlayerController(PlayerRepository());
  ValueNotifier<List<PlayerSummaryModel>> players = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
      ),
      body: ValueListenableBuilder<List<PlayerSummaryModel>>(
        valueListenable: players,
        builder: (_, list, __) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, idx) {
              var player = list[idx];

              return ListTile(
                leading: player.avatar != null ? CircleAvatar(
                  backgroundImage: MemoryImage(player.avatar!),
                )
                : const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Container(
                  decoration: player.namecard != null
                    ? BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(player.namecard!),
                        fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(8),
                    )
                    : null,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    player.name,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamed(
                  '/pDetails', 
                  arguments: player
                ),
              );
            }
          );
        },
      ),
    );
  }

  _getIcon(PlayerSummaryModel player) {
    return Icons.add_circle;
  }

  _fetch() async {
    var result = await _playerController.buscarPlayer("Blurryface");
    for (var player in result) {
      var playerDetails = await _playerController.buscarPlayer(player.playerId);
      player.avatar = await _playerController.buscarImagem(playerDetails.avatar);
      player.namecard = await _playerController.buscarImagem(playerDetails.namecard);
    }
    players.value = result;
  }
}