import 'package:flutter/material.dart';
import 'package:ow_battlelog/controllers/player_controller.dart';
import 'package:ow_battlelog/models/player_model.dart';
import 'package:ow_battlelog/models/player_summary_model.dart';
import 'package:ow_battlelog/repositories/player_repository.dart';

class ListDataPlayer extends StatefulWidget {
  const ListDataPlayer({super.key});

  @override
  State<ListDataPlayer> createState() => _ListDataPlayerState();
}

class _ListDataPlayerState extends State<ListDataPlayer> {
  final PlayerController _playerController = PlayerController(PlayerRepository());

  ValueNotifier<PlayerModel> playerData = ValueNotifier(
    PlayerModel.empty(),
  );

  late PlayerSummaryModel playerSum;
  bool _isInitialized = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      playerSum = ModalRoute.of(context)!.settings.arguments as PlayerSummaryModel;
      _fetch();
      _isInitialized = true;
    }
  }

  Future<void> _fetch() async {
    setState(() {
      _isLoading = true;
    });
    playerData.value = await _playerController.buscarPlayer(playerSum.playerId);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var player = playerData.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(player.username.isEmpty ? 'Carregando...' : player.username),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildRanksSection(player),
                ],
              ),
            ),
    );
  }

  /// Header com avatar e namecard
  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(playerSum.avatar),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(playerSum.namecard),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              playerSum.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Seção de Ranks (em construção)
  Widget _buildRanksSection(PlayerModel player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ranks',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRankCard('Tank', player.competitive.pc.tank.rankIcon),
            _buildRankCard('Damage', player.competitive.pc.damage.rankIcon),
            _buildRankCard('Support', player.competitive.pc.support.rankIcon),
            _buildRankCard('Open Queue', player.competitive.pc.open.rankIcon),
          ],
        ),
      ],
    );
  }

  /// Widget individual para cada rank
  Widget _buildRankCard(String role, String iconUrl) {
    return Column(
      children: [
        Image.network(
          iconUrl,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
        ),
        const SizedBox(height: 4),
        Text(role, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
