import 'package:flutter/material.dart';
import 'package:ow_battlenet/controllers/player_controller.dart';
import 'package:ow_battlenet/models/competitive_status_model.dart';
import 'package:ow_battlenet/models/endorsement.dart';
import 'package:ow_battlenet/models/player_model.dart';
import 'package:ow_battlenet/models/player_summary_model.dart';
import 'package:ow_battlenet/repositories/player_repository.dart';
import 'dart:typed_data';
import 'package:ow_battlenet/widgets/image_from_bytes.dart';


class ListDataPlayer extends StatefulWidget {
  const ListDataPlayer({super.key});

  @override
  State<ListDataPlayer> createState() => _ListDataPlayerState();
}

class _ListDataPlayerState extends State<ListDataPlayer> {
  final PlayerController _playerController =
      PlayerController(PlayerRepository());

  ValueNotifier<PlayerModel> playerData = ValueNotifier(
    PlayerModel('', '', '', '', Endorsement(), CompetitiveStatusModel(), 0),
  );

  late PlayerSummaryModel playerSum;
  bool _isInitialized = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      playerSum =
          ModalRoute.of(context)!.settings.arguments as PlayerSummaryModel;
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
        title: Text(
          player.username.isEmpty ? 'Carregando...' : player.username,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      ImageFromBytes(
                        bytes: playerSum.avatar,
                        width: 100,
                        height: 200,
                      ),
                      ImageFromBytes(
                        bytes: playerSum.namecard,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Ranks (em construção)'),
                  Row(
                    children: [
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  /// Widget para exibir imagem diretamente dos bytes
  Widget _buildImageFromBytes(Uint8List? bytes, double width, double height) {
    if (bytes == null || bytes.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported, size: 50),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(bytes),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
