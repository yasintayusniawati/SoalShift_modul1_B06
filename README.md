# SoalShift_modul1_B06

## Oleh Kelompok B06 :
1. Yasinta Yusniawati   05111740000054
2. Bima Satria Ramadhan 05111740000081

## Jawaban

### No 1
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

#### Bash Script

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
