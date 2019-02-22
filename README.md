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
<ol type="a">
<li> Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
<li> Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
<li> Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.
 </ol>

## No 3 (isi ya)
## No 4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:
<ol type="a">
<li> Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.
<li> Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.
<li> setelah huruf z akan kembali ke huruf a
<li> Backup file syslog setiap jam.
<li> dan buatkan juga bash script untuk dekripsinya.
</ol>

### 4.1 Bash script enkripsi
```
#!/bin/bash

jam=$(date "+%H")
kecil=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
besar=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

file=$(date "+%H:%M %d-%m-%y")
cat /var/log/syslog | tr "${kecil:0:26}" "${kecil:$jam:26}" | tr "${besar:0:26}" "${besar:$jam:26}" > "/home/yasinta/Documents/praktikum1/$jam" 
```

#### Penjelasan
+ `#!/bin/bash` **(Shebang)** berfungsi untuk memberitahu sistem bahwa perintah-perintah yg ada di dalam file tersebut harus dijalankan oleh Bash.
+ `jam=$(date "+%H")` *Jam* adalah variabel yang digunakan untuk menampung jam sedangkan *date "+%H"* perintah untuk menampilkan jam
+ `kecil=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz`variabel untuk menampung string pola huruf kecil dari [a-z] 
+ `besar=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ`variabel untuk menampung string pola huruf besar dari [A-Z]
+ `file=$(date "+%H:%M %d-%m-%y")`variabel untuk menampung nama file dengan fortmat *“jam:menit tanggal-bulan-tahun”*
+ `cat /var/log/syslog` menyatukan file dan mencetak pada output standar dari file syslog *'/var/log/syslog'*
+  `tr "${kecil:0:26}" "${kecil:$jam:26}" | tr "${besar:0:26}" "${besar:$jam:26}"` mengganti file syslog dari huruf [a-z | A-Z] menjadi string file + jam. Misal : isi file adalah string *yasinta* dan jam menunjukkan pukul 12:00, maka file enkripsinya menjadi *kmeuzfm*
+ ` > "/home/yasinta/Documents/praktikum1/$jam"` file dengan format *“jam:menit tanggal-bulan-tahun”* akan disimpan di dalam direktori /home/yasinta/Documents/praktikum1

### 4.2 Bash script dekripsi
```
!/bin/bash

#Field Separator -> Pemisah Field/data
jam=$(echo "$1" | cut -d':' -f1)

kecil=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
besar=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
geser=$((26-${jam}))

file=$(date "+%H:%M %d-%m-%y")
cat "$1" | tr "${kecil:0:26}" "${kecil:$geser:26}" | tr "${besar:0:26}" "${besar:$geser:26}" > "/home/yasinta/Documents/praktikum1/dekripsi$1"
```

#### Penjelasan
+ `!/bin/bash` **(Shebang)** berfungsi untuk memberitahu sistem bahwa perintah-perintah yg ada di dalam file tersebut harus dijalankan oleh Bash.
+ `jam=$(echo "$1" | cut -d':' -f1)` *jam* adalah variabel untuk menampung file, *echo "$1"* menampilkan argumen pertama pada file, *cut -d':'* membagi menjadi 2 bagian yang dipisahkan oleh tanda *:* misal : file nya bernama 12:00 22-feb-2019 maka file tersebut akan dipisah menjadi **12** dan **00 22-feb-2019**, dan *-f1* untuk mengambil jam nya dalam contoh tadi yang di ambil adalah *12*
+ `kecil=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz`variabel untuk menampung string pola huruf kecil dari [a-z] 
+ `besar=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ`variabel untuk menampung string pola huruf besar dari [A-Z]
+ `geser=$((26-${jam}))` variabel yang menampung hasil dekripsi dari string manipulation, jika sekarang jam 12:00 maka string 'm' bila didekripsi menjadi string 'a'
+ `file=$(date "+%H:%M %d-%m-%y")`variabel untuk menampung nama file dengan fortmat *“jam:menit tanggal-bulan-tahun”*
+ `cat "$1" | tr "${kecil:0:26}" "${kecil:$geser:26}" | tr "${besar:0:26}" "${besar:$geser:26}"` mengambil file dengan kalimat depannya jam kemudian mendekripsi file tersebut seperti semula
+ `> "/home/yasinta/Documents/praktikum1/dekripsi$1"` file dengan format *“dekripsijam:menit tanggal-bulan-tahun”* akan disimpan di dalam direktori /home/yasinta/Documents/praktikum1

### 4.3 Cron
Perintah untuk backup file syslog setiap jam adalah :
```
@hourly /bin/bash /home/yasinta/Documents/praktikum1/soal4.sh
```
#### Penjelasan 
+ `@hourly /bin/bash` berarti dijalankan setiap jam
+ `/home/yasinta/Documents/praktikum1/soal4.sh` path script yang akan di eksekusi

## No 5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:
<ol type="a">
<li> Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.
<li> Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.
<li> Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
<li> Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.
</ol>

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

### 5.2 Cron
Perintah untuk menjalankan script tadi setiap 6 menit dari menit ke 2 hingga 30 adalah :

```
2-30/6 * * * * /bin/bash /home/yasinta/Documents/soal5.sh
```

#### Penjelasan
+ `2-30/6 * * * * /bin/bash`  menjalankan script tadi setiap 6 menit dari menit ke 2 hingga 30. Misal : 13:02, 13:08, 13:14, dst
+ `/home/yasinta/Documents/soal5.sh` path script yang akan di eksekusi


