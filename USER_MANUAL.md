# BUKU PANDUAN (USER MANUAL)
**Sistem Informasi Manajemen Aset PT Semen Tonasa**

Dokumen ini berisi panduan teknis langkah demi langkah untuk melakukan instalasi, konfigurasi, dan penjelasan rinci mengenai setiap modul/fitur yang ada di dalam aplikasi ini.

---

## BAGIAN A: CARA MENJALANKAN PROYEK (INSTALLATION GUIDE)

Sistem ini dibangun menggunakan ekosistem **Node.js** dan **Next.js**, dengan database **PostgreSQL**.

### 1. Prasyarat Sistem
Pastikan komputer/server Anda telah menginstal perangkat lunak berikut:
- **Node.js** (Disarankan versi 18.x LTS atau lebih baru).
- **PostgreSQL** (Versi 14 atau lebih baru).

### 2. Konfigurasi Database
1. Buka PostgreSQL (menggunakan pgAdmin atau psql).
2. Buat database baru dengan nama `inventaris_tonasa` (atau nama lain sesuai keinginan).
3. Anda **tidak perlu** membuat tabel secara manual. Sistem akan otomatis mendeteksi dan membuat tabel (skema) saat pertama kali dijalankan.

### 3. Konfigurasi Proyek
1. Ekstrak file ZIP `Handover_Semen_Tonasa.zip`.
2. Buka terminal/Command Prompt, arahkan ke folder ekstraksi tersebut.
3. Jalankan perintah instalasi modul (wajib koneksi internet):
   ```bash
   npm install
   ```
4. Buat file baru bernama `.env` di folder utama (sejajar dengan `package.json`). Anda bisa menyalin format dari `.env.example`. Isi dengan konfigurasi berikut:
   ```env
   # Konfigurasi Database PostgreSQL
   DB_USER=postgres
   DB_PASSWORD=password_postgres_anda
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=inventaris_tonasa

   # Konfigurasi Keamanan (Wajib diganti dengan string acak di production!)
   SECRET_KEY=SangatRahasia123

   # Konfigurasi Pengirim Email Reminder
   EMAIL_USER=email.anda@gmail.com
   EMAIL_PASS=password_app_google_anda
   ```

### 4. Menjalankan Sistem
Di terminal yang sama, jalankan perintah:
```bash
npm run dev
```
Buka browser dan akses **`http://localhost:3001`**. (Port dapat berbeda tergantung konfigurasi `package.json` Anda).

### 5. Mengembalikan Data Dummy (Seeding)
Jika Anda ingin sistem langsung terisi dengan data contoh (termasuk akun Admin dan kontrak lahan):
1. Buka terminal baru di folder proyek.
2. Jalankan perintah:
   ```bash
   node seed_data.js
   ```
3. Database akan otomatis terisi dan siap digunakan.

---

## BAGIAN B: PENJELASAN DETAIL FITUR (FEATURE DETAILS)

Aplikasi ini dibagi menjadi beberapa halaman utama yang dapat diakses melalui Menu Navigasi di sebelah kiri (Sidebar).

### 1. Autentikasi (Login & Proteksi Akses)
- Sistem dilengkapi dengan pengamanan token JWT (JSON Web Token).
- Terdapat sistem *Rate Limiting* yang memblokir IP peretas jika mencoba login dengan password salah berkali-kali.
- Terdapat tingkatan *Role/Hak Akses*: `admin_utama`, `admin`, `operator`, `karyawan`, dan `user`.

### 2. Dashboard Terintegrasi
- **Ringkasan (Statistik):** Menampilkan jumlah total aset, aset yang butuh persetujuan (approval), dan pembagian jumlah aset berdasarkan kategorinya (Tanah, Bangunan, Kendaraan, dll).
- **Grafik Interaktif (Chart.js):** Visualisasi sebaran aset per kategori untuk pelaporan cepat kepada manajemen.
- **Riwayat Aktivitas Terakhir:** Menampilkan 8 aktivitas terakhir (siapa menambah apa, siapa mengedit apa) secara *real-time*.

### 3. Manajemen Aset Induk (`/aset`)
Ini adalah "Jantung" dari aplikasi. 
- **Tabel Inventaris:** Menampilkan daftar seluruh aset lengkap dengan fitur *Pencarian* cepat dan *Filter* berdasarkan Kategori.
- **Form Input Lanjutan:** Formulir penambahan aset dilengkapi dengan integrasi **Peta Geospasial (BPN/Google Maps Hybrid)**. Pengguna bisa langsung memasukkan Nomor Sertifikat Lahan dan sistem akan memvisualisasikan batas-batas lahannya.
- **Otomatisasi Wilayah:** Input lokasi sudah menggunakan *Cascading API* (pilih Provinsi -> memfilter Kabupaten/Kota secara otomatis).
- **Pengaturan Sewa (Khusus Tanah):** Saat memasukkan aset kategori "Tanah", formulir otomatis memunculkan kolom Nama Penyewa, Tanggal Mulai Sewa, dan Tanggal Akhir Sewa.

### 4. Kontrak Sewa Lahan (`/kontrak-sewa`)
Fitur khusus yang dikembangkan untuk memonitor kerjasama dengan pihak luar (seperti penyewaan lahan ke Bank atau vendor lain).
- **Tabel Monitoring:** Menampilkan Nomor Kontrak, Lokasi, Nama Penyewa, dan sisa masa waktu (jatuh tempo).
- **Kode Warna Status:**
  - 🟢 Hijau: Aman (Lebih dari 90 hari)
  - 🟡 Kuning/Warning: Akan berakhir (Kurang dari 90 hari)
  - 🔴 Merah: Telah kedaluwarsa.
- **Generate PDF:** Anda bisa menekan tombol aksi untuk langsung mengunduh Surat Peringatan Sewa dalam format PDF.
- **Pengingat Otomatis (Cron Job Email):** Fitur berjalan di *background*. Setiap jam 08:00 pagi, sistem akan mengecek. Jika ada kontrak yang mencapai tepat "3 bulan sebelum jatuh tempo", sistem akan otomatis membuat file PDF peringatan dan mengirimkannya via Email ke Admin dan pengelola lahan.

### 5. Sistem Persetujuan / Approval (`/persetujuan`)
Menjaga integritas data agar tidak sembarang diubah oleh karyawan tingkat bawah.
- Setiap kali aset baru ditambahkan, aset tersebut masuk dalam status *Pending*.
- Hanya akun dengan role `admin` atau `admin_utama` yang bisa menekan tombol **Setujui (Approve)** atau **Tolak (Reject)**. Aset tidak akan terlihat di Laporan jika belum disetujui.

### 6. Histori Aset (`/histori`)
- Log Audit penuh. Mencatat setiap perubahan (Edit/Hapus) aset, mencatat siapa yang mengubah, kapan diubah, dan deskripsi apa yang berubah. Sangat penting untuk audit kepatuhan perusahaan.

### 7. Laporan Eksekutif (`/laporan`)
- Menampilkan data lengkap aset yang sudah di-Approve.
- Tombol **Ekspor Excel** dan **Ekspor CSV** untuk keperluan pelaporan akhir tahun atau rapat jajaran direksi.

### 8. Manajemen Pengguna (`/pengguna`)
- (Khusus Admin): Fasilitas untuk menambahkan, mengedit, mengubah password, dan mengatur Hak Akses (*Role*) untuk karyawan dan staf lain yang menggunakan aplikasi.

---
*Dokumen ini disusun untuk keperluan serah terima operasional kepada PT Semen Tonasa.*
