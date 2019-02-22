# SoalShift_modul1_C06

1. Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
<br>Hint: Base64, Hexdump

Jawab :
<br>(pendahuluan)
<br>Extract file nature.zip terlebih dahulu. Bisa dengan extract biasa dari file manager atau melalui terminal dengan syntax *unzip (direktori_asal/nama_file_lama) -d (direktori_tujuan/nama_file_baru)*.
 - Pertama, kita menentukan syntax untuk men-dekripsi file.

> base64 -d (direktori_asal/nama_file_mula) | xxd -r > (direktori_tujuan/nama_file_baru)

*base64* adalah syntax untuk encode atau decode. Karena disini kami ingin membuka file yang telah dienkripsi, maka kita menggunakan opsi -d untuk decode.
<br>*xxd* adalah syntax untuk membuat hexdump atau sebaliknya. Karena disini kami ingin mengonversi hexdump ke bentuk biner, maka kita menggunakan opsi -r untuk reverse.
 - Kemudian, kita membuat loop untuk men-dekripsi seluruh file yang ada di folder nature. Misal kita ingin hasil dekripsi file disimpan dengan nama numerik (1,2,3…).
 
> i=1
<br>for var in (direktori_asal)/*.jpg
<br>do
<br>base64 -d $var | xxd -r > (direktori_tujuan)/$i.jpg
<br>i=$(($i + 1))
<br>done

variabel i digunakan untuk menamai file hasil dekripsi. Supaya nama file berbeda untuk setiap file, maka increment nilai i setiap kali mendekripsi sebuah file.
<br>variabel *var* digunakan untuk menyimpan direktori_asal dari file. Maksud dari for var in (direktori_asal)/*.jpg adalah selama dalam variabel var terdapat file berekstensi .jpg, maka lakukan loop tersebut.
- Tambahkan syntax *#!/bin/bash* di line 1 kemudian simpan dengan nama soal1.sh
- Untuk syarat pengeksekusiannya, maka dilakukan dengan crontab. Ketikkan crontab -e, lalu isikan

> 14 14 * 2 5 /bin/bash (direktori)/soal1.sh
<br>14 14 14 2 * /bin/bash (direktori)/soal1.sh

Berdasarkan crontab.guru 14 14 * 2 5 berarti “At 14:14 on Friday in February” dan 14 14 14 2 * berarti “At 14:14 on day-of-month 14 in February”.

2. Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv. Laporan yang diminta berupa:

a. Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
<br>Syntax :

> echo "(2a)"
<br>awk -F , '{ if ($7=='2012') i[$1]+=$10 } END {for(hasil in i) {print hasil}}' (direktori)/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=1 {print}'

syntax *awk -F ,* berarti kita menambahkan nilai separator berupa , (koma).
<br>kemudian karena kita memilih negara dengan penjualan pada tahun 2012, maka diberi kondisi *if ($7=='2012')* dan menjalankan pernyataan *i[$1]+=$10* yang berarti kita membuat array i dengan indeks berupa kolom 1, yaitu nama negara dan set nilainya dengan menambahkan nilai yang ada pada kolom 10, yaitu kuantitas.
<br>syntax dilanjutkan dengan *{for(hasil in i) {print hasil}}* untuk menyimpan arraynya dalam variabel hasil.
<br>syntax *sort -nr* berarti mengurutkan berdasar numerik nya, yaitu hasil penjumlahan quantity tiap negara
<br>dan *awk ‘NR<=1 {print}’* berarti menampilkan negara dengan penjualan terbanyak (yaitu teratas setelah di-sort)

b. Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a
<br>Dari soal a, kita mendapatkan bahwa negara dengan penjualan tertinggi adalah United States, sehingga
<br>Syntax :

> echo "(2b)"
<br>awk -F , '{if($7=='2012' && $1=="United States") i[$4]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' (direktori)/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3}'

syntax *awk -F ,* berarti kita menambahkan nilai separator berupa , (koma).
<br>kemudian karena kita memilih product line dengan penjualan pada tahun 2012 dari negara United States, maka diberi kondisi *if ($7=='2012' && $1==”United States”)* dan menjalankan pernyataan *i[$4]+=$10* yang berarti kita membuat array i dengan indeks berupa kolom 4, yaitu product line dan set nilainya dengan menambahkan nilai yang ada pada kolom 10, yaitu kuantitas.
<br>syntax dilanjutkan dengan *{for(hasil in i) {print hasil}}* untuk menyimpan arraynya dalam variabel hasil.
<br>syntax *sort -nr* berarti mengurutkan berdasar numerik nya, yaitu hasil penjumlahan quantity tiap product line
<br>dan *awk ‘NR<=3 {print $2, $3}’* berarti menampilkan 3 product line dengan penjualan terbanyak (yaitu teratas setelah di-sort)

c. Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.
<br>Dari soal b, kita mendapatkan bahwa product line dengan penjualan tertinggi adalah Personal Accessories, Camping Equipment, dan Outdoor Protection sehingga
<br>Syntax :

> echo "(2c)"
> 
> echo "-Personal Accessories-"
<br>awk -F , '{if($7=='2012' && $1=="United States" && $4=="Personal Accessories") i[$6]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' (direktori)/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3, $4}'
> 
> echo "-Camping Equipment-"
<br>awk -F , '{if($7=='2012' && $1=="United States" && $4=="Camping Equipment") i[$6]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' (direktori)/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3, $4}'
> 
> echo "-Outdoor Protection-"
<br>awk -F , '{if($7=='2012' && $1=="United States" && $4=="Outdoor Protection") i[$6]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' (direktori)/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3, $4}'

syntax *awk -F ,* berarti kita menambahkan nilai separator berupa , (koma).
<br>kemudian karena kita memilih product dengan penjualan pada tahun 2012 dari negara United States dan product line tertentu, maka diberi kondisi *if ($7=='2012' && $1==”United States” && $4==”(nama product line)”)* dan menjalankan pernyataan *i[$6]+=$10* yang berarti kita membuat array i dengan indeks berupa kolom 6, yaitu tipe produk dan set nilainya dengan menambahkan nilai yang ada pada kolom 10, yaitu kuantitas.
<br>syntax dilanjutkan dengan *{for(hasil in i) {print hasil}}* untuk menyimpan arraynya dalam variabel hasil.
<br>syntax *sort -nr* berarti mengurutkan berdasar numerik nya, yaitu hasil penjumlahan quantity tiap tipe produk
<br>dan *awk ‘NR<=3 {print $2, $3, $4}’* berarti menampilkan 3 tipe produk dengan penjualan terbanyak (yaitu teratas setelah di-sort)
<br>Tambahkan syntax *#!/bin/bash* di line 1 kemudian simpan dengan nama soal2.sh
