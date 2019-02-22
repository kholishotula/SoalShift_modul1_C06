# SoalShift_modul1_C06

<br>05111740000030 Kholishotul Amaliah
<br>05111740000180 Nandha Himawan<br>

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
<br>kemudian karena kita memilih product dengan penjualan pada tahun 2012 dari negara United States dan product line tertentu, maka diberi kondisi *if ($7=='2012' && $1==”United States” && $4==”(nama product line)”)* dan menjalankan pernyataan *i[$6]+=$10* yang berarti kita membuat array i dengan indeks berupa kolom 6, yaitu produk dan set nilainya dengan menambahkan nilai yang ada pada kolom 10, yaitu kuantitas.
<br>syntax dilanjutkan dengan *{for(hasil in i) {print hasil}}* untuk menyimpan arraynya dalam variabel hasil.
<br>syntax *sort -nr* berarti mengurutkan berdasar numerik nya, yaitu hasil penjumlahan quantity tiap produk
<br>dan *awk ‘NR<=3 {print $2, $3, $4}’* berarti menampilkan 3 produk dengan penjualan terbanyak (yaitu teratas setelah di-sort)
<br>Tambahkan syntax *#!/bin/bash* di line 1 kemudian simpan dengan nama soal2.sh

3. Buatlah sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, huruf kecil, dan angka. Password acak tersebut disimpan pada file berekstensi .txt dengan ketentuan pemberian nama sebagai berikut:

a. Jika tidak ditemukan file password1.txt maka password acak tersebut disimpan pada file bernama password1.txt
<br>b. Jika file password1.txt sudah ada maka password acak baru akan disimpan pada file bernama password2.txt dan begitu seterusnya.
<br>c. Urutan nama file tidak boleh ada yang terlewatkan meski filenya dihapus.
<br>d. Password yang dihasilkan tidak boleh sama.

JAWAB :
- Untuk menghasilkan password secara random, kami menggunakan /dev/urandom yaitu sebuah files dimana berisi kumpulan karakter dan simbol2 random.
- Lalu kami pipe sesuai aturan soal, dimana password hanya berisi angka dan huruf besar dan kecil menggunakan aturan:

> tr -dc 'a-zA-Z0-9'

Fungsi dari syntax diatas adalah “mengambil” hanya karakter yang di inginkan saja, dalam kasus ini huruf besar, huruf kecil dan angka. Lalu saya simpan hasil passwordnya dalam variable tes.
- Untuk penyimpanan passwordnya, saya menggunakan looping karena tidak ada urutan nama file yang boleh terlewatkan, berikut kode nya :

> n=1
<br>flag=0
<br>while [ $flag==0 ]
<br>do 
<br>if [ $(find (direktori)/shift -name password$n.txt | wc -l) -gt 0 ] 
<br>then
<br>flag=0 
<br>let n=$n+1
<br>else
<br>echo $tes > (direktori)/password$n.txt
<br>flag=1
<br>break
<br>fi
<br>done

- Pertama saya set variable n = 1 dan flag = 0, n untuk nomor filenya dan flag untuk tanda apakah file tersebut sudah ada atau belum. Lalu selama flag = 0, yang artinya file tersebut belum ada, lalu arti baris

> if [ $(find (direktori)/shift -name password$n.txt | wc -l) -gt 0 ] 
<br>then
<br>flag=0 
<br>let n=$n+1

Adalah, jika file bernama passwordn.txt sudah ada, maka flag diset tetap 0, lalu nilai n ditambah 1, lalu jika file tersebut belum ada,

>else
<br>echo $tes > (direktori)/password$n.txt
<br>flag=1
<br>break

maka kita masukan isi variable tes tadi kedalam file password”n”.txt lalu kita set flag menjadi 1 dan break loop nya.

4. Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (_string manipulation_) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki urutan ke 12+2 = 14.
<br>b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke empat belas, dan seterusnya.
<br>c. setelah huruf z akan kembali ke huruf a
<br>d. Backup file syslog setiap jam.
<br>e. dan buatkan juga bash script untuk dekripsinya.

JAWAB :
- Pertama kami buat variable tggl dan hour, tggl berfungsi menyimpan tanggal berapa saat script tersebut di jalankan dan hour untuk menyimpan jamnya. Lalu ada sedikit kondisi 

> if [ $hour -lt 10 ]
<br>then
<br>hour=$(echo $hour | tr -d '0')
<br>fi

yaitu jika jam nya kurang dari jam 10, yang berarti jam 09 sampai jam 01, maka kita hapuskan digit ‘0’ nya supaya variable hour bisa digunakan dalam perhitungan.

- Lalu untuk enkripsi nya, kita disuruh menswap/mengganti huruf yang ada dengan huruf yang baru. Ketentuan nya jika script tersebut dijalankan pada jam 1 malam misalnya, maka huruf a(urutan ke 1 dalam alphabet) , 1+1 = 2, maka huruf a akan menjadi b, huruf b akan menjadi c, dan seterusnya sampai huruf z menjadi a.
<br>Maka yang kami lakukan disini adalah :

> a="abcdefghijklmnopqrstuvwxyz"
<br>for ((i=1; i<=$hour; i=i+1))
<br>do
<br> for ((j=1; j<=25; j=j+1))
<br> do
<br>  swap=${a:$j:1}
<br>  a=$(echo $a | tr $swap '0')
<br>  swap2=${a:$j-1:1}
<br>  a=$(echo $a | tr ${a:$j-1:1} $swap)
<br>  a=$(echo $a | tr ${a:$j:1} $swap2)
<br> done
<br>done

Membuat variable a yang berisi string a sampai z, lalu menggeser mereka berapa kali sesuai jam berapa script tersebut dijalankan, misal jam 1, maka akan digeser 1 kali.
<br>Maka variable a akan menjadi “bcdefghijklmnopqrstuvwxyza”. Dan untuk melakukan nya saya gunakan nested loop. Dimana for yang pertama adalah untuk mengulang sebanyak “jam”. Dan for yang kedua untuk melakukan swap/penggeseran string nya.

Untuk menggeser string nya, misal ada string “abc” maka saya simpan karakter ke-2, yaitu b kedalam variable swap, lalu saya tukar karakter b menjadi angka “0”. Lalu saya simpan karakter a kedalam swap2 dan saya menukar karakter ke 1 menjadi karakter ke-2 yang sudah disimpan dalam variable swap, dan karakter ke-2 menjadi karakter ke-1 yang sudah disimpan dalam variable swap2. Dan hal tersebut dilakukan sebanyak panjang stringnya dikurangi 1. Jika string “abc” memiliki 3 karakter, maka hal tersebut dilakukan sebanyak 2 kali.
<br>Ilustrasi nya seperti ini :

> “abc” ; swap = b ; swap2 = a
<br>“a0c”
<br>“bac” swap = a ; swap2 = c
<br>“ba0”
<br>“bca”

Hal tersebut juga saya lakukan untuk huruf besar/kapital :

> b="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
<br>for ((i=1; i<=$hour; i=i+1))
<br>do
<br> for ((j=1; j<=25; j=j+1))
<br> do
<br>  sw=${a:$j:1}
<br>  a=$(echo $a | tr $sw '0')
<br>  sw2=${a:$j-1:1}
<br>  a=$(echo $a | tr ${a:$j-1:1} $sw)
<br>  a=$(echo $a | tr ${a:$j:1} $sw2)
<br> done
<br>done

Lalu untuk menukar/mengganti urutan alphabet didalam file syslog tersebut adalah

> cat /var/log/syslog>(direktori)/tessoal4.txt
<br>cat (direktori)/tessoal4.txt | tr 'a-z' $a | tr 'A-Z' $b > (direktori)/"$tggl".txt

Pertama kami simpan isi file syslog kedalam tessoal4.txt, lalu file tessoal4.txt tersebut kami pipe dengan

> tr 'a-z' $a | tr 'A-Z' $b

fungsinya adalah untuk mengganti urutan alphabet yang semula a sampai z, menjadi urutan yang telah kita dapatkan. Variable a untuk huruf kecil dan variable b untuk huruf besar/kapital. Lalu hasilnya kita simpan dalam file berbentuk jam:menit tanggal-bulan-tahun yang sudah kita simpan diawal menjadi variable tggl.

Untuk dekripsinya :

>#!/bin/bash
<br>find (direktori) -name "*:* *-*-*"
<br>echo "File mana yang mau di dekripsi? (inputkan nama file)"
<br>read tggl
<br>hour=$(echo ${tggl:0:2})
<br>if [ $hour -lt 10 ]
<br>then
<br>hour=$(echo $hour | tr -d '0')
<br>fi
<br><br>a="abcdefghijklmnopqrstuvwxyz"
<br>for ((i=1; i<=$hour; i=i+1))
<br>do
<br> for ((j=1; j<=25; j=j+1))
<br> do
<br>  swap=${a:$j:1}
<br>  a=$(echo $a | tr $swap '0')
<br>  swap2=${a:$j-1:1}
<br>  a=$(echo $a | tr ${a:$j-1:1} $swap)
<br>  a=$(echo $a | tr ${a:$j:1} $swap2)
<br> done
<br>done
<br><br>b="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
<br>for ((i=1; i<=$hour; i=i+1))
<br>do
<br> for ((j=1; j<=25; j=j+1))
<br> do
<br>  sw=${a:$j:1}
<br>  a=$(echo $a | tr $sw '0')
<br>  sw2=${a:$j-1:1}
<br>  a=$(echo $a | tr ${a:$j-1:1} $sw)
<br>  a=$(echo $a | tr ${a:$j:1} $sw2)
<br> done
<br>done
<br>cat (direktori)/"$tggl".txt | tr  $a 'a-z'| tr  $b 'A-Z'> (direktori)/jawaban4reverse.txt

Hampir sama seperti saat mengenkripsi file, kita harus tau jam berapa file tersebut di enkripsi, lalu tukar/geser string a dan b sesuai berapa jam yang diketahui, lalu bedanya adalah saat langkah terakhir :

>cat (direktori)/"$tggl".txt | tr  $a 'a-z'| tr  $b 'A-Z'> (direktori)/jawaban4reverse.txt

Kita tukar urutan alphabet yang ada dalam file tersebut, kembali menjadi a sampai z, dan simpan hasilnya pada file jawaban4reverse.txt

Lalu karena kita disuruh backup setiap jam, maka gunakan crontab :

> 0 */1 * * * /bin/bash (direktori)/soal4.sh

Setiap jam lewat 0 menit, soal4.sh akan dijalankan.

5. Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi kriteria berikut:

a. Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya  tidak bersifat _case sensitive_, sehingga huruf kapital atau tidak, tidak menjadi masalah.
<br>b. Jumlah field (_number of field_) pada baris tersebut berjumlah kurang dari 13.
<br>c. Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.
<br>d. Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

JAWAB :

Kita menggunakan awk untuk memfilter file syslog sesuai soal diatas.

> #!/bin/bash
<br>awk 'NF<13 && tolower($0) ~ /cron/ && tolower($0) !~ /sudo/' /var/log/syslog > (direktori)/user.log

Untuk poin a, kita gunakan tolower() untuk menghilangkan case sensitive nya,

> tolower($0) ~ /cron/ && tolower($0) !~ /sudo/' /var/log/syslog

kode berikut berarti, untuk setiap record/baris yang mengandung kata cron dan tidak mengandung kata sudo.

Lalu poin b, jumlah field kurang dari 13, kita gunakan “NF < 13”  dan hasilnya kita masukkan pada /var/log/user.log

Sehingga, hanya mengandung string cron dan tidak ada string sudo serta number of fieldsnya  < 13. Lalu untuk poin d, dimana kita harus menjalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst. Maka gunakan crontab 

> 2-30/6 * * * * /bin/bash (direktori)/soal5.sh
