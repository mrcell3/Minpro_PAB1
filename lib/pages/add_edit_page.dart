import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/penghuni.dart';

class AddEditPage extends StatefulWidget {
  final Penghuni? penghuni;

  const AddEditPage({super.key, this.penghuni});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _nomorKamarController;
  late TextEditingController _nomorHPController;
  late TextEditingController _tanggalMasukController;
  late TextEditingController _hargaSewaController;

  bool get isEdit => widget.penghuni != null;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.penghuni?.nama ?? '');
    _nomorKamarController = TextEditingController(text: widget.penghuni?.nomorKamar ?? '');
    _nomorHPController = TextEditingController(text: widget.penghuni?.nomorHP ?? '');
    _tanggalMasukController = TextEditingController(text: widget.penghuni?.tanggalMasuk ?? '');
    _hargaSewaController = TextEditingController(text: widget.penghuni?.hargaSewa ?? '');
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomorKamarController.dispose();
    _nomorHPController.dispose();
    _tanggalMasukController.dispose();
    _hargaSewaController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final penghuni = Penghuni(
        id: widget.penghuni?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        nama: _namaController.text.trim(),
        nomorKamar: _nomorKamarController.text.trim(),
        nomorHP: _nomorHPController.text.trim(),
        tanggalMasuk: _tanggalMasukController.text.trim(),
        hargaSewa: _hargaSewaController.text.trim(),
      );
      Navigator.pop(context, penghuni);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF162447),
        foregroundColor: Colors.white,
        title: Text(
          isEdit ? 'Edit Penghuni' : 'Tambah Penghuni',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF162447), Color(0xFF0D1B35)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.person_add_outlined, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEdit ? 'Edit Data Penghuni' : 'Data Penghuni Baru',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Lengkapi semua field di bawah ini',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Form
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Informasi Personal'),
                    const SizedBox(height: 12),
                    _buildField(
                      label: 'Nama Lengkap',
                      controller: _namaController,
                      icon: Icons.person_outline,
                      hint: 'Masukkan nama penghuni',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Nama tidak boleh kosong';
                        return null;
                      },
                    ),
                    _buildField(
                      label: 'Nomor HP',
                      controller: _nomorHPController,
                      icon: Icons.phone_outlined,
                      hint: 'Contoh: 08123456789',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Nomor HP tidak boleh kosong';
                        if (v.trim().length < 10) return 'Nomor HP minimal 10 digit';
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    _sectionTitle('Informasi Kamar'),
                    const SizedBox(height: 12),
                    _buildField(
                      label: 'Nomor Kamar',
                      controller: _nomorKamarController,
                      icon: Icons.door_back_door_outlined,
                      hint: 'Contoh: A1',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Nomor kamar tidak boleh kosong';
                        return null;
                      },
                    ),
                    _buildField(
                      label: 'Tanggal Masuk',
                      controller: _tanggalMasukController,
                      icon: Icons.calendar_today_outlined,
                      hint: 'Contoh: 01/01/2024',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Tanggal masuk tidak boleh kosong';
                        return null;
                      },
                    ),
                    _buildField(
                      label: 'Harga Sewa per Bulan (Rp)',
                      controller: _hargaSewaController,
                      icon: Icons.payments_outlined,
                      hint: 'Contoh: 1500000',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Harga sewa tidak boleh kosong';
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _simpan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF162447),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isEdit ? 'Simpan Perubahan' : 'Tambah Penghuni',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFF162447),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFBBBBBB)),
              prefixIcon: Icon(icon, color: const Color(0xFF162447), size: 20),
            ),
          ),
        ],
      ),
    );
  }
}