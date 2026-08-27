CREATE DATABASE IF NOT EXISTS siakad_itaf CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE siakad_itaf;

CREATE TABLE IF NOT EXISTS users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 username VARCHAR(50) NOT NULL UNIQUE,
 password_hash VARCHAR(255) NOT NULL,
 role ENUM('admin','mahasiswa') NOT NULL DEFAULT 'mahasiswa',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS students (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 user_id INT UNSIGNED NOT NULL UNIQUE,
 nim VARCHAR(50) NOT NULL UNIQUE,
 nama VARCHAR(150) NOT NULL,
 tempat_lahir VARCHAR(100) NOT NULL,
 tanggal_lahir DATE NOT NULL,
 jenis_kelamin ENUM('Laki-laki','Perempuan') NOT NULL,
 prodi ENUM('Teknik Informatika','Teknik Mesin','Teknik Lingkungan') NOT NULL,
 fakultas VARCHAR(150) NOT NULL DEFAULT 'Fakultas Teknologi',
 semester TINYINT UNSIGNED NOT NULL,
 status ENUM('Aktif','Cuti','Nonaktif') NOT NULL DEFAULT 'Aktif',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT fk_student_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE,
 INDEX idx_students_prodi(prodi), INDEX idx_students_semester(semester)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS courses (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 prodi ENUM('Teknik Informatika','Teknik Mesin','Teknik Lingkungan') NOT NULL,
 semester TINYINT UNSIGNED NOT NULL,
 kode VARCHAR(30) NOT NULL,
 nama VARCHAR(200) NOT NULL,
 sks TINYINT UNSIGNED NOT NULL,
 UNIQUE KEY uq_course(prodi,semester,kode)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS krs (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 student_id INT UNSIGNED NOT NULL,
 course_id INT UNSIGNED NOT NULL,
 semester TINYINT UNSIGNED NOT NULL,
 status ENUM('Diajukan','Disetujui','Ditolak') NOT NULL DEFAULT 'Diajukan',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_krs(student_id,semester,course_id),
 CONSTRAINT fk_krs_student FOREIGN KEY(student_id) REFERENCES students(id) ON DELETE CASCADE,
 CONSTRAINT fk_krs_course FOREIGN KEY(course_id) REFERENCES courses(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS grades (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 krs_id INT UNSIGNED NOT NULL UNIQUE,
 nilai VARCHAR(2) NULL,
 bobot DECIMAL(3,2) NOT NULL DEFAULT 0,
 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT fk_grade_krs FOREIGN KEY(krs_id) REFERENCES krs(id) ON DELETE CASCADE
) ENGINE=InnoDB;

INSERT INTO users(username,password_hash,role)
SELECT 'admin', '$2y$12$2fUgi61cqu5yj/dhQOnEdOEtSzgqV82II0szRLiO0uiL0zuTO4ih.', 'admin'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username='admin');
-- Password admin di atas: admin123
USE siakad_itaf;
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',1,'IF0101','Pendidikan Agama',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',1,'IF0102','Bahasa Indonesia',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',1,'IF0103','Pancasila',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',1,'IF0104','Pengantar Teknologi Informasi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',2,'IF0201','Matematika Dasar',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',2,'IF0202','Algoritma dan Pemrograman',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',2,'IF0203','Struktur Data',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',2,'IF0204','Sistem Operasi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',3,'IF0301','Basis Data',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',3,'IF0302','Pemrograman Web',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',3,'IF0303','Jaringan Komputer',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',3,'IF0304','Rekayasa Perangkat Lunak',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',4,'IF0401','Matematika Diskrit',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',4,'IF0402','Sistem Digital',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',4,'IF0403','Arsitektur Komputer',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',4,'IF0404','Analisis dan Perancangan Sistem',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',5,'IF0501','Pemrograman Berorientasi Objek',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',5,'IF0502','Kecerdasan Buatan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',5,'IF0503','Interaksi Manusia dan Komputer',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',5,'IF0504','Pemrograman Mobile',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',6,'IF0601','Keamanan Informasi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',6,'IF0602','Data Mining',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',6,'IF0603','Cloud Computing',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',6,'IF0604','Machine Learning',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',7,'IF0701','Pengembangan Aplikasi Enterprise',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',7,'IF0702','Manajemen Proyek TI',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',7,'IF0703','Sistem Informasi Manajemen',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',8,'IF0801','Internet of Things',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',8,'IF0802','Analitik Data',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',8,'IF0803','DevOps',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',9,'IF0901','Forensik Digital',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',9,'IF0902','Etika Profesi Teknologi Informasi',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',9,'IF0903','Metodologi Penelitian',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',10,'IF1001','Kewirausahaan Teknologi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',10,'IF1002','Tata Kelola TI',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',10,'IF1003','Big Data',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',11,'IF1101','Pengolahan Citra Digital',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',11,'IF1102','Pemrosesan Bahasa Alami',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',11,'IF1103','Sistem Terdistribusi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',12,'IF1201','Pengembangan Game',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',12,'IF1202','Seminar Proposal',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',12,'IF1203','Magang',4);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',13,'IF1301','Kuliah Kerja Nyata',4);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',13,'IF1302','Seminar Hasil',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',13,'IF1303','Skripsi',6);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',14,'IF1401','Proyek Akhir',6);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',14,'IF1402','Topik Khusus Informatika',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Informatika',14,'IF1403','Praktikum Pemrograman',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',1,'TM0101','Pendidikan Agama',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',1,'TM0102','Bahasa Indonesia',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',1,'TM0103','Pancasila',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',1,'TM0104','Pengantar Teknik Mesin',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',2,'TM0201','Matematika Teknik I',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',2,'TM0202','Fisika Dasar',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',2,'TM0203','Menggambar Teknik',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',2,'TM0204','Material Teknik',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',3,'TM0301','Matematika Teknik II',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',3,'TM0302','Statika',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',3,'TM0303','Kinematika dan Dinamika',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',3,'TM0304','Termodinamika I',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',4,'TM0401','Mekanika Fluida I',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',4,'TM0402','Kekuatan Material I',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',4,'TM0403','Proses Manufaktur',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',4,'TM0404','Elemen Mesin I',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',5,'TM0501','Termodinamika II',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',5,'TM0502','Perpindahan Kalor',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',5,'TM0503','Mekanika Fluida II',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',5,'TM0504','Kekuatan Material II',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',6,'TM0601','Elemen Mesin II',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',6,'TM0602','Mesin Konversi Energi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',6,'TM0603','Sistem Kontrol',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',6,'TM0604','Metrologi Industri',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',7,'TM0701','Teknik Pengelasan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',7,'TM0702','Teknik Pembentukan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',7,'TM0703','Perawatan Mesin',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',8,'TM0801','Manajemen Industri dan Proyek',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',8,'TM0802','Prestasi Mesin',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',8,'TM0803','Perancangan Mesin',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',9,'TM0901','Teknik Pendingin',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',9,'TM0902','Motor Bakar',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',9,'TM0903','CAD/CAM',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',10,'TM1001','Otomasi Industri',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',10,'TM1002','Ergonomi Industri',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',10,'TM1003','Kewirausahaan Teknik',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',11,'TM1101','Metodologi Penelitian',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',11,'TM1102','Keselamatan dan Kesehatan Kerja',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',11,'TM1103','Manajemen Energi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',12,'TM1201','Teknologi Tepat Guna',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',12,'TM1202','Seminar Proposal',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',12,'TM1203','Magang Industri',4);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',13,'TM1301','Kuliah Kerja Nyata',4);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',13,'TM1302','Seminar Hasil',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',13,'TM1303','Skripsi',6);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',14,'TM1401','Proyek Perancangan Mesin',6);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',14,'TM1402','Topik Khusus Teknik Mesin',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Mesin',14,'TM1403','Praktikum Mesin',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',1,'TL0101','Pendidikan Agama',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',1,'TL0102','Bahasa Indonesia',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',1,'TL0103','Pancasila',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',1,'TL0104','Pengantar Teknik Lingkungan',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',2,'TL0201','Matematika Dasar',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',2,'TL0202','Kimia Dasar',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',2,'TL0203','Fisika Dasar',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',2,'TL0204','Biologi Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',3,'TL0301','Kimia Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',3,'TL0302','Mikrobiologi Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',3,'TL0303','Hidrologi',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',3,'TL0304','Mekanika Fluida',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',4,'TL0401','Pengelolaan Kualitas Air',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',4,'TL0402','Sistem Penyediaan Air Minum',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',4,'TL0403','Pengolahan Air Limbah',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',4,'TL0404','Pengelolaan Sampah',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',5,'TL0501','Pencemaran Udara',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',5,'TL0502','Pencemaran Tanah',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',5,'TL0503','Hidraulika Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',5,'TL0504','Drainase Perkotaan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',6,'TL0601','Teknologi Pengolahan Air',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',6,'TL0602','Teknologi Pengolahan Air Limbah',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',6,'TL0603','Pengelolaan Limbah B3',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',6,'TL0604','Analisis Mengenai Dampak Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',7,'TL0701','Kesehatan Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',7,'TL0702','Sanitasi Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',7,'TL0703','Teknik Pengendalian Pencemaran Udara',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',8,'TL0801','Manajemen Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',8,'TL0802','Ekologi Industri',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',8,'TL0803','Remediasi Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',9,'TL0901','Konservasi Sumber Daya Air',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',9,'TL0902','Pengelolaan Daerah Aliran Sungai',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',9,'TL0903','Teknologi Tepat Guna Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',10,'TL1001','Sistem Informasi Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',10,'TL1002','Kewirausahaan Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',10,'TL1003','Ekonomi Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',11,'TL1101','Metodologi Penelitian',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',11,'TL1102','Keselamatan Kerja Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',11,'TL1103','Mitigasi Bencana Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',12,'TL1201','Audit Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',12,'TL1202','Seminar Proposal',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',12,'TL1203','Magang Lapangan',4);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',13,'TL1301','Kuliah Kerja Nyata',4);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',13,'TL1302','Seminar Hasil',2);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',13,'TL1303','Skripsi',6);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',14,'TL1401','Proyek Perancangan Lingkungan',6);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',14,'TL1402','Topik Khusus Teknik Lingkungan',3);
INSERT IGNORE INTO courses(prodi,semester,kode,nama,sks) VALUES('Teknik Lingkungan',14,'TL1403','Praktikum Lingkungan',2);
