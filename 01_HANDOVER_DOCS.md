# Dokumentasi Serah Terima (Handover Document)
**Sistem Informasi Manajemen Aset PT Semen Tonasa**

---

**Dikembangkan oleh:** Irfan Jamal Passalowongi  
**Tahun:** 2026  
**Status:** V1.0 (Production Ready)  

---

## 1. Pendahuluan
Sistem ini merupakan aplikasi manajemen aset terintegrasi yang dirancang untuk PT Semen Tonasa. Dibangun dengan fokus pada kemudahan penggunaan (UI/UX), keamanan data, dan fleksibilitas manajerial, sistem ini memungkinkan pencatatan, pelacakan histori, fitur approval berlapis, serta pemantauan otomatis (reminder) kontrak sewa lahan geospasial.

**Catatan Lisensi & Hak Cipta:**  
Hak kekayaan intelektual atas arsitektur, basis kode (source code), dan desain awal sistem ini sepenuhnya merupakan milik **Irfan Jamal Passalowongi**. PT Semen Tonasa diberikan lisensi penuh untuk menggunakan, mengelola, dan memodifikasi aplikasi ini untuk operasional internal. Sang kreator (Irfan Jamal Passalowongi) berhak menggunakan proyek ini sebagai bagian dari dokumentasi portofolio profesional, presentasi karir, dan keperluan akademis tanpa batasan.

## 2. Arsitektur Sistem (Tech Stack)
- **Frontend & Backend Framework:** [Next.js (React)](https://nextjs.org/) - Versi 16+
- **Database:** PostgreSQL (Diintegrasikan menggunakan `pg` dengan wrapper custom di `lib/db.js` agar sintaks mirip SQLite untuk kemudahan transisi).
- **Styling:** CSS Murni dengan beberapa animasi modern (*Glassmorphism*, *Fade-in*, dll).
- **Automasi (Cron Job):** `node-cron` untuk tugas-tugas background.
- **Pembuatan PDF:** `pdfkit` untuk meng-generate surat resmi.
- **Email Service:** `nodemailer` untuk notifikasi email.

## 3. Fitur Utama
1. **Dashboard Statistik:** Ringkasan jumlah aset per kategori dan notifikasi aset yang perlu di-*approve*. Menampilkan grafik interaktif.
2. **Sistem Autentikasi & Otorisasi Berlapis:** Terdapat role `admin_utama`, `admin`, `operator`, `karyawan`, dan `user`. Hanya admin yang bisa menyetujui (approve) perubahan.
3. **Manajemen Grup Aset:** Mencakup berbagai kategori (Tanah, Bangunan, Kendaraan, Mesin, dll).
4. **Validasi & Integrasi Geospasial (ATR/BPN):** Input lahan terintegrasi dengan Google Maps dan API Wilayah (Provinsi/Kabupaten/Kecamatan) otomatis.
5. **Reminder Sewa Lahan Otomatis:** Sistem mengecek setiap jam 08:00 pagi. Jika kontrak lahan akan berakhir dalam 90 hari (3 bulan), sistem otomatis membuat surat PDF dan mengirimkannya ke email Admin.

## 4. Struktur Folder Penting
- `pages/api/[[...all]].js`: Merupakan inti (core) dari seluruh logika backend (REST API) yang memproses CRUD aset, approval, login, dan email.
- `pages/`: Berisi semua halaman antarmuka (frontend).
- `lib/db.js`: Skrip koneksi database dan skema (schema) awal database. Di sinilah juga *cron job* diinisialisasi.
- `lib/cron.js`: Berisi script untuk penjadwalan (scheduler) otomatis.
- `components/`: Komponen UI modular (seperti `Sidebar.js`, `Layout.js`).

## 5. Panduan Menjalankan Proyek
Bagi developer yang akan memegang proyek ini selanjutnya, ikuti langkah berikut:
1. Pastikan **Node.js** (versi 18 atau ke atas) sudah terinstal.
2. Pastikan database PostgreSQL sudah berjalan dan kredensialnya disesuaikan.
3. Buka terminal di folder proyek ini.
4. Jalankan perintah instalasi modul (jika belum):
   ```bash
   npm install
   ```
5. Untuk menjalankan server dalam mode pengembangan (development):
   ```bash
   npm run dev
   ```
6. Aplikasi akan berjalan di `http://localhost:3001` (atau port yang disesuaikan di `package.json`).

## 6. Penutup
Semua kode telah ditulis dengan standar industri terbaik, rapi, dan mudah untuk diskalakan (scalable). Jika di kemudian hari tim IT internal ingin menambahkan fitur baru, disarankan untuk mempelajari cara kerja routing di `pages/api/[[...all]].js` terlebih dahulu. 

Sukses selalu untuk PT Semen Tonasa dan tim pengelola aset!
