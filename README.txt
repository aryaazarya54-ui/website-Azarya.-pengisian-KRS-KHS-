SIAKAD INSTITUT TEKNOLOGI ALBERTH FOENAY (ITAF)
================================================
VERSI PHP + MYSQL - DATABASE TERPUSAT

Fitur:
- Portal Mahasiswa dan Portal Admin
- 3 Prodi: Teknik Informatika, Teknik Mesin, Teknik Lingkungan
- Semester 1 sampai 14
- Registrasi mahasiswa: NIM, nama, tempat/tanggal lahir, jenis kelamin, prodi, fakultas, semester, status
- KRS maksimal 24 SKS
- KHS dan Transkrip
- Admin: dashboard, data mahasiswa, katalog mata kuliah, monitoring KRS, input nilai
- Password disimpan dengan password_hash PHP
- Session server-side

CARA INSTALASI XAMPP
1. Salin folder aplikasi ini ke C:\xampp\htdocs\siakad_itaf
2. Jalankan Apache dan MySQL dari XAMPP.
3. Buka phpMyAdmin: http://localhost/phpmyadmin
4. Import file database.sql. File tersebut membuat database siakad_itaf, tabel, akun admin, dan katalog mata kuliah.
5. Jika konfigurasi MySQL berbeda, edit DB_HOST, DB_NAME, DB_USER, DB_PASS di config.php.
6. Buka http://localhost/siakad_itaf/

AKUN ADMIN
Username: admin
Password: admin123

DATABASE ONLINE
Untuk hosting, buat database MySQL pada hosting, import database.sql, lalu isi config.php sesuai Host, Nama Database, Username, dan Password dari hosting.
Jangan menggunakan akun database root pada hosting produksi.

CATATAN
Versi ini tidak menggunakan localStorage untuk data akademik utama. Pendaftaran mahasiswa, KRS, dan nilai disimpan di MySQL sehingga perangkat mahasiswa dan komputer admin dapat mengakses data yang sama melalui server.
