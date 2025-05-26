import 'package:flutter/material.dart';
import 'package:ow_battlelog/controllers/player_controller.dart';
import 'package:ow_battlelog/models/player_summary_model.dart';
import 'package:ow_battlelog/repositories/player_repository.dart';

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
        title: const Text("Players"),
      ),
      body: ValueListenableBuilder<List<PlayerSummaryModel>>(
        valueListenable: players,
        builder: (_, list, __) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, idx) {
              var player = list[idx];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(player.avatar),
                ),
                title: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(player.namecard),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    player.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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

  Future<void> _fetch() async {
    var result = await _playerController.buscarPlayer("Blurryface");
    players.value = result;
  }
}