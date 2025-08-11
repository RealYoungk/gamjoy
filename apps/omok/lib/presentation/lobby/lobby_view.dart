import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omok/presentation/lobby/lobby_provider.dart';

class LobbyView extends ConsumerWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lobbyState = ref.watch(lobbyNotifierProvider);
    final onlineCount = ref.watch(onlinePlayerCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('오목 로비'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '접속자: $onlineCount명',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: lobbyState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    '오목 게임에 오신 것을 환영합니다!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await ref.read(lobbyNotifierProvider.notifier).createRoom();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('방이 생성되었습니다!')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('방 생성 실패: $e')),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('새 게임 방 만들기'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: lobbyState.roomList.isEmpty
                      ? const Center(
                          child: Text(
                            '현재 생성된 방이 없습니다.\n새 방을 만들어보세요!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: lobbyState.roomList.length,
                          itemBuilder: (context, index) {
                            final roomName = lobbyState.roomList[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ListTile(
                                title: Text(roomName),
                                subtitle: const Text('대기 중 • 1/2'),
                                trailing: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await ref
                                          .read(lobbyNotifierProvider.notifier)
                                          .joinRoom(roomName);
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('방에 참가했습니다!')),
                                        );
                                      }
                                    } catch (e) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('참가 실패: $e')),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text('참가'),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: lobbyState.isLoading
            ? null
            : () async {
                try {
                  await ref.read(lobbyNotifierProvider.notifier).createRoom();
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('오류 발생: $e')),
                    );
                  }
                }
              },
        tooltip: '빠른 게임',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}