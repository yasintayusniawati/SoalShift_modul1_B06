# Soal Shift Modul1 B06

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
 
### 2.1 Bash Script

```
#!/bin/bash

echo "--a--"
negara=$(awk -F ',' '{if($7 == '2012') a[$1]+=$10} END {for (i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -n | awk -F ',' '{print $1}' | tail -1)
echo "$negara"
printf "\n"

echo "--b--"
awk -F',' -v negara="$negara" '{if(($1==negara) && ($7 == 2012)) a[$4]+=$10} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3
printf "\n"

echo "--c--"
produk1="Personal Accessories"
printf "Top 3 Product dari Personal Accessories : \n"
awk -F',' -v produk1="$produk1" '{if(($1=="United States") && ($4==produk1) && ($7 == 2012)) a[$6]+=$10} END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3

produk2="Camping Equipment"
printf "\nTop 3 Product dari Camping Equipment : \n"
awk -F',' -v produk2="$produk2" '{if(($1=="United States") && ($4==produk2) && ($7 == 2012)) a[$6]+=$10} END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3

produk3="Outdoor Protection"
printf "\nTop 3 Product dari Outdoor Protection : \n"
awk -F',' -v produk3="$produk3" '{if(($1=="United States") &&($4==produk3) && ($7 == 2012)) a[$6]+=$10} END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3
```

### Penjelasan
+ **2a**
  + `awk -F ','` menghilangkan separator tanda koma (,)
  + `{if($7 == '2012') a[$1]+=$10}` mengecek tahun yang diinginkan yaitu 2012 jika iya maka dihitung jumlah quantity yang mana ada di urutan $10 untuk dijumlahkan dan ditampung dalam array tiap negara sehingga bisa menghitung jumlah quantity tiap negara
  + `{for (i in a) print i",",a[i]}` melakukan looping untuk print nama negara beserta jumlah quantitynya
  + `sort -n` untuk mengurutkan urutan quantitynya dari yang terkecil ke terbesar
  + `awk -F ',' '{print $1}` print nama negaranya saja
  + `tail -1)` mengambil urutan yang paling akhir yang mana merupakan negara dengan quantity terbanyak
+ **2b**
  + `awk -F ','` menghilangkan separator tanda koma (,)
  + `-v negara="$negara"` mengambil nilai negara yang dihasilkan di (A) yaitu United States
  + `{if(($1==negara) && ($7 == 2012)) a[$4]+=$10} ` mengecek negara adalah United States dan tahun yang diinginkan yaitu 2012 jika iya maka dihitung jumlah quantity yang mana ada di urutan $10 untuk dijumlahkan dan ditampung dalam array tiap product line sehingga bisa menghitung jumlah quantity tiap product line
  + `{for (i in a) print i",",a[i]}` melakukan looping untuk print nama product line beserta jumlah quantitynya
  + `sort -nr` untuk mengurutkan urutan quantitynya dari yang terbesar ke terkecil
  + `awk -F ',' '{print $2}` print nama product line saja
  + `head -3` mengambil 3 urutan yang paling awal yang mana merupakan product line dengan quantity terbanyak berdasarkan negara jawaban (A) yaitu United States
+ **2c**
  + `produk1="Personal Accessories"`menyimpan Personal Accessories pada produk1
  + `-v produk1="$produk1"` mengambil nilai produk1
  + `awk -F ','` menghilangkan separator tanda koma (,)
  + `{if(($1=="United States") && ($4==produk1) && ($7 == 2012)) a[$6]+=$10}` mengecek negara adalah United States dan tahun yang diinginkan yaitu 2012 serta productnya sesuai yang dicari yaitu produk1 jika iya maka dihitung jumlah quantity yang mana ada di urutan $10 untuk dijumlahkan dan ditampung dalam array tiap product ehingga bisa menghitung jumlah quantity tiap product
  + `{for (i in a) print i",",a[i]}` melakukan looping untuk print nama product beserta jumlah quantitynya
  + `sort -nr` untuk mengurutkan urutan quantitynya dari yang terbesar ke terkecil
  + `awk -F ',' '{print $2}` print nama product saja
  + `head -3` mengambil 3 urutan yang paling awal yang mana merupakan product line dengan quantity terbanyak berdasarkan product line terbanyak yang dihasilkan jawaban (B)
  + perintah yang dilakukan selanjutnya sama yang membedakan hanya pada yang dicari selanjutnya yaitu 3 produk terbanyak yang berdarkan product line terbanyak kedua dan product line terbanyak ketiga


## No 3 
Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:
<ol type="a">
<li> Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
<li> Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.
<li> Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
<li> Password yang dihasilkan tidak boleh sama.
</ol>

### 3.1 Bash Script
```
#!/bin/bash

i=1
file=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)

while [ -f ./password"$i".txt  ]
do
  if [ "$file" == "$(cat ./password"$i".txt)" ]
  then
    file=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)
    i=1
  else
    let "i++"
  fi
done

echo "$file" > password"$i".txt
```

#### Penjelasan
+ `i=1` inisialisasi i awal adalah 1
+ `file=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)`perintah untuk generate password secara acak 
+ `while [ -f ./password"$i".txt  ]` untuk mengecek selama ada file password"$i".txt maka perintah di dalam while akan dijalankan
+ `if [ "$file" == "$(cat ./password"$i".txt)" ]` mengecek apakah password yang digenerate sama dengan yang telah tersimpan jika iya maka i akan bernilai 1 dan akan mengecek dari awal semua yang tersimpan apakah sama dengan yang baru digenerate sehingga tidak akan ada password yang sama
+ `echo "$file" > password"$i".txt` menyimpan password yang digenerate ke dalam password"$i".txt


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


