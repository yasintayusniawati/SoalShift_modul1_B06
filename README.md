# SoalShift_modul1_B06

## Oleh Kelompok B06 :
1. Yasinta Yusniawati   05111740000054
2. Bima Satria Ramadhan 05111740000081

## Jawaban

## No 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

### 1.1 Bash Script

```
#!/bin/bash

unzip /home/yasinta/Documents/praktikum1/nature.zip -d /home/yasinta/Documents/praktikum1
dir="/home/yasinta/Documents/praktikum1"
mkdir $dir/hasil

n=0

for foto in $dir/nature/*.jpg;
do
 base64 --decode $foto | xxd -r > $dir/hasil/$n.jpg
 n=$((n+1))
done
```

#### Penjelasan
+ `#!/bin/bash` **(Shebang)** berfungsi untuk memberitahu sistem bahwa perintah-perintah yg ada di dalam file tersebut harus dijalankan oleh Bash.
+ `unzip /home/yasinta/Documents/praktikum1/nature.zip -d /home/yasinta/Documents/praktikum1` **unzip** digunakan untuk mengekstrak atau menguraikan file yang dikompres dengan zip. Dalam bash script terledak dalam direktory /home/yasinta/Documents/praktikum1/nature.zip dan akan diletakkan di /home/yasinta/Documents/praktikum1.
+ `dir="/home/yasinta/Documents/praktikum1"`variabel yang digunakan untuk menampung file hasil zip.
+ `mkdir $dir/hasil` membuat direktory baru setelah proses unzip berhasil yang bernama hasil.
+ `n=0` membuat agar file gambar yang telah di unzip dimulai dari n
+ `for foto in $dir/nature/*.jpg;`semua foto yang berada di direktory nature.zip
+ `base64 --decode $foto | xxd -r > $dir/hasil/$n.jpg`menggunakan base64 untuk mendecode file dan **xxd -r**
 adalah reverse operation untuk mengubah hexdump ke binary
+ `n=$((n+1))` membuat agar file gambar yang telah di unzip dimulai dari n+1 dan seterusnya. Misal : 1.jpg

### 1.2 Cron
Perintah cron untuk membuka seluruh file tersebut pukul 14:14 pada tanggal 14 Februari atau hari jumat pada bulan Februari adalah sebagai berikut :

```
14 14 14 2 5 /bin/bash /home/yasinta/Documents/praktikum1/soal1.sh
```
#### Penjelasan 
+ `14 14 14 2 5 /bin/bash` berarti  pukul 14:14 pada tanggal 14 Februari atau hari jumat pada bulan Februari
+ `/home/yasinta/Documents/praktikum1/soal1.sh` path script yang akan di eksekusi



## No 2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:
+ a) Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
+ b) Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
+ c) Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

## No 3 (isi ya)
## No 4 (susah jelasinnya)

## No 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
+ a) Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
+ b) Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
+ c) Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
+ d) Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

### 5.1 Bash Script
```
awk '/cron/ || /CRON/,!/sudo/' /var/log/syslog | awk 'NF < 13' >> /home/yasinta/modul1/nomor5.log
```

#### Penjelasan
+ `/cron/ || /CRON/` mengambil baris yang mengandung kata 'cron' atau 'CRON'
+ `!/sudo/` mengambuil baris yang tidak mengandung kata sudo
+ `/var/log/syslog` file yang akan di ambil
+ `| awk 'NF < 13'` perintah sebelumnya menjadi input dari `awk 'NF < 13` dimana Number of field kurang dari 13
+ `>> /home/yasinta/modul1/nomor5.log` hasil dari awk dimasukkan ke file /home/yasinta/modul1/nomor5.log
