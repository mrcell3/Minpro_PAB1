import 'package:flutter/material.dart';
import '../models/penghuni.dart';
import '../widgets/penghuni_card.dart';
import 'add_edit_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Penghuni> _daftarPenghuni = [];

  void _navigasiKeAddEdit({Penghuni? penghuni}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditPage(penghuni: penghuni)),
    );

    if (result != null && result is Penghuni) {
      setState(() {
        if (penghuni == null) {
          _daftarPenghuni.add(result);
        } else {
          final index = _daftarPenghuni.indexWhere((p) => p.id == result.id);
          if (index != -1) _daftarPenghuni[index] = result;
        }
      });
    }
  }

  void _hapusPenghuni(String id) {
    setState(() {
      _daftarPenghuni.removeWhere((p) => p.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: const Color(0xFF162447),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF162447), Color(0xFF0D1B35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'KostKu',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_daftarPenghuni.length} Penghuni Terdaftar',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _statCard('Total Kamar', '${_daftarPenghuni.length}', Icons.door_back_door_outlined),
                            const SizedBox(width: 12),
                            _statCard('Terisi', '${_daftarPenghuni.length}', Icons.people_outline),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daftar Penghuni',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  Text(
                    '${_daftarPenghuni.length} orang',
                    style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
                  ),
                ],
              ),
            ),
          ),
          if (_daftarPenghuni.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF162447).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.people_outline, size: 40, color: Color(0xFF162447)),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Belum ada penghuni',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Tambah penghuni dengan tombol + di bawah',
                      style: TextStyle(fontSize: 13, color: Color(0xFF888888)),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final penghuni = _daftarPenghuni[index];
                  return PenghuniCard(
                    penghuni: penghuni,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            penghuni: penghuni,
                            onHapus: () => _hapusPenghuni(penghuni.id),
                            onUpdated: (updated) {
                              setState(() {
                                final index = _daftarPenghuni.indexWhere((p) => p.id == updated.id);
                                if (index != -1) _daftarPenghuni[index] = updated;
                              });
                            },
                          ),
                        ),
                      );
                      setState(() {});
                    },
                  );
                },
                childCount: _daftarPenghuni.length,
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigasiKeAddEdit(),
        backgroundColor: const Color(0xFF162447),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Penghuni', style: TextStyle(fontWeight: FontWeight.w600)),
        elevation: 4,
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}