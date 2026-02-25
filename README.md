# KostKu 🏠

Aplikasi mobile manajemen penghuni kost berbasis Flutter. Dirancang untuk membantu pemilik kost dalam mengelola data penghuni secara mudah dan efisien.

---

## Deskripsi Aplikasi

KostKu adalah aplikasi sederhana namun fungsional untuk mencatat dan mengelola data penghuni kost. Pengguna dapat menambahkan data penghuni baru, melihat daftar seluruh penghuni, melihat detail per penghuni, mengedit data yang sudah ada, serta menghapus data penghuni yang sudah keluar.

---

## Fitur Aplikasi

| Fitur | Keterangan |
|---|---|
| ➕ Tambah Penghuni | Menambahkan data penghuni baru melalui form input |
| 📋 Lihat Daftar | Menampilkan semua penghuni dalam bentuk card list |
| 🔍 Detail Penghuni | Melihat informasi lengkap satu penghuni |
| ✏️ Edit Penghuni | Mengubah data penghuni yang sudah tersimpan |
| 🗑️ Hapus Penghuni | Menghapus data penghuni dengan konfirmasi dialog |

---

## Struktur Folder

```
lib/
├── main.dart
├── models/
│   └── penghuni.dart
├── pages/
│   ├── home_page.dart
│   ├── add_edit_page.dart
│   └── detail_page.dart
└── widgets/
    └── penghuni_card.dart
```

---

## Widget yang Digunakan

| Widget | Kegunaan |
|---|---|
| `MaterialApp` | Root aplikasi dengan konfigurasi tema global |
| `Scaffold` | Struktur dasar setiap halaman |
| `CustomScrollView` + `SliverAppBar` | Header yang dapat expand/collapse di Home dan Detail |
| `FlexibleSpaceBar` | Konten dalam SliverAppBar |
| `SliverList` + `SliverFillRemaining` | List penghuni dan tampilan kosong |
| `GestureDetector` | Mendeteksi tap pada card penghuni |
| `Container` | Styling custom box dengan dekorasi |
| `LinearGradient` | Background gradient warna navy |
| `BoxShadow` | Efek bayangan pada card |
| `Form` + `GlobalKey<FormState>` | Form dengan validasi |
| `TextFormField` | Input field dengan validator |
| `FilteringTextInputFormatter` | Membatasi input Nomor HP hanya angka |
| `ElevatedButton` + `OutlinedButton` | Tombol aksi simpan, edit, dan hapus |
| `FloatingActionButton.extended` | Tombol tambah penghuni di Home |
| `AlertDialog` | Dialog konfirmasi sebelum hapus data |
| `Navigator` + `MaterialPageRoute` | Navigasi antar halaman (multi-page) |

---
