# ristek-todo-app

## Pembelajaran

Selama proses pembuatan app ini, saya mempelajari banyak hal tentang build mobile app dengan Flutter. Saya memahami bagaimana cara menggunakan **widget bawaan** untuk membangun UI serta membuat **custom widget** agar memberikan kesan clean code dan design yang reusable.

Selain itu, saya juga belajar cara menggunakan `setState` untuk memperbarui seluruh halaman dan `Notifiers` agar hanya bagian tertentu dari UI yang diperbarui tanpa merender ulang seluruh page, sehingga performa lebih optimal.

Saya juga mempelajari cara import dan menggunakan **dependencies** untuk menambah fitur app. Beberapa package yang saya gunakan antara lain:

- **SharedPreferences** – Penyimpanan data lokal
- **Flutter Launcher Icons** – Mengatur ikon app
- **intl** – Format tanggal dan waktu
- **url_launcher** – Membuka app external untuk akses link
- **image_picker** – Memilih gambar dari galeri/kamera

Selain itu, saya mempelajari bagaimana cara menggunakan **SharedPreferences** untuk menyimpan data primitif seperti `string` dan `int`, serta data non-primitif dengan konversi **JSON String** agar data tetap tersimpan setelah app ditutup.

Saya juga memahami cara kerja `initState` untuk inisialisasi data sebelum UI ditampilkan dan `dispose` untuk membersihkan resource agar mencegah memory leak.

Selain itu, saya belajar bagaimana cara **mengimport gambar dan font** agar dapat digunakan dalam app, termasuk konfigurasi di `pubspec.yaml`.
Selain belajar cara mengimport gambar dan font, saya juga mempelajari bagaimana cara **mengedit** `AndroidManifest.xml` **dan** `Info.plist` untuk membatasi fitur tertentu di app saya, seperti memblokir mode landscape dan mengubah nama app di OS tertentu.

## Referensi

Referensi utama yang saya gunakan dalam proses ini adalah:
- [The Ultimate Flutter Tutorial for Beginners - 2025 Full Course](https://www.youtube.com/watch?v=3kaGC_DrUnw)
- **StackOverflow** untuk kasus spesifik
- **Chatbot seperti ChatGPT** sebagai referensi tambahan untuk berbagai kasus

## Kesimpulan

Secara keseluruhan, proses pembelajaran ini memberikan saya insight mendalam tentang bagaimana cara build mobile app dengan Flutter, khususnya dalam **optimasi performa, manajemen state, pemanfaatan dependencies, dan penggunaan library eksternal**.