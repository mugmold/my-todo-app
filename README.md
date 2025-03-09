# ristek-todo-app

RistekTodo adalah aplikasi To-Do List yang dibangun menggunakan Flutter. Aplikasi ini memungkinkan pengguna untuk menambahkan, mengedit, dan menghapus daftar tugas mereka dengan mudah. Selain fitur manajemen tugas, aplikasi ini juga memiliki fitur **Data Pribadi**, yang di mana pengguna dapat menyimpan informasi seperti foto profil, nama lengkap, username, hobi, dan tautan media sosial mereka. Semua data akan tersimpan secara lokal agar dapat diakses meskipun aplikasi ditutup.

## Fitur Aplikasi

- Tambah, edit, dan hapus tugas, serta data pribadi pengguna.
- Penyimpanan data secara lokal.
- Menampilkan tanggal dan waktu dalam format yang disesuaikan.
- Memasukkan gambar dari galeri/kamera sebagai foto profil di bagian data pengguna.

## Pembelajaran

Dalam pengembangan aplikasi ini, saya mempelajari:

- **Widget Flutter**: Menggunakan **widget bawaan** ataupun **custom widget** untuk clean code dan UI yang reusable.
- **State Management**: `setState` untuk update halaman dan `Notifiers` agar hanya sebagian UI yang keupdate, sehingga lebih efisien.
- **Debounce**: Mencegah event berulang seperti snackbar muncul berkali-kali.
- **SharedPreferences**: Menyimpan data lokal, baik primitif maupun non-primitif dengan konversi **JSON String**.
- **Lifecycle Methods**: `initState` untuk inisialisasi data, `dispose` untuk mencegah memory leak.
- **Konfigurasi App**: Mengedit `pubspec.yaml`, `AndroidManifest.xml` untuk Android dan `Info.plist` untuk iOS supaya dapat mengatur fitur seperti mode layar dan nama aplikasi.

## Dependencies

Saya juga mempelajari cara import dan menggunakan **dependencies** untuk menambah fitur app. Beberapa package yang saya gunakan antara lain:

- **SharedPreferences** – Penyimpanan data lokal
- **Flutter Launcher Icons** – Mengatur ikon app
- **intl** – Format tanggal dan waktu
- **url_launcher** – Membuka app external untuk akses link
- **image_picker** – Memilih gambar dari galeri/kamera

## Referensi

Referensi utama yang saya gunakan dalam proses ini adalah:
- [The Ultimate Flutter Tutorial for Beginners - 2025 Full Course](https://www.youtube.com/watch?v=3kaGC_DrUnw)
- **StackOverflow** untuk kasus spesifik
- **Chatbot seperti ChatGPT** sebagai referensi tambahan untuk berbagai kasus