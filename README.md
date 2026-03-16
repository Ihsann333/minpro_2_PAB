# minpro_2

## Nur Ihsan

## 2409116051

## Deskripsi Aplikasi

RoomAja merupakan aplikasi mobile berbasis Flutter yang digunakan untuk melakukan pemesanan kamar hotel secara digital. Aplikasi ini dirancang dengan tampilan yang sederhana dan modern sehingga pengguna dapat melakukan proses booking dengan mudah.

Sebelum menggunakan aplikasi, pengguna harus melakukan login atau registrasi terlebih dahulu. Setelah berhasil masuk ke dalam aplikasi, pengguna dapat melihat daftar booking kamar hotel yang tersedia serta menambahkan data pemesanan baru.

Pada halaman form booking, pengguna dapat memilih hotel, menentukan jumlah kamar, mengatur jumlah tamu dewasa dan anak, serta memilih tanggal check-in dan check-out. Data booking yang telah dibuat akan ditampilkan pada halaman utama dalam bentuk daftar.

Aplikasi RoomAja juga mendukung pengaturan tema **Light Mode dan Dark Mode**, sehingga pengguna dapat menyesuaikan tampilan aplikasi sesuai dengan preferensi mereka.

## Fitur Aplikasi


![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/5c469b68a0030159318a631dda6bb02e821b360f/317bd19e-5b14-4f4f-b2c3-491f022dac46.jpg)

1. **Login Pengguna**

   Pengguna dapat masuk ke aplikasi menggunakan email dan password yang telah terdaftar.
   

![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/488311f128561ae404cdb943eb6d2a69ebf70a19/043b6574-cbf0-496a-87b8-f50c7681650a.jpg)

2. **Registrasi Pengguna**

   Pengguna yang belum memiliki akun dapat membuat akun baru melalui halaman register.
   

![image](https://github.com/Ihsann333/minpro_2_PAB/blob/cb556b690e94f53ff81962032ab915aa4f824d19/9eb3af2a-8bb6-402a-90d9-5c97c784fbca.jpg)

3. **Menampilkan Daftar Booking**

   Aplikasi menampilkan daftar booking kamar hotel dalam bentuk list yang dapat di-scroll.
   

![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/3711b4cd4a104b6a5effd823cc90bcdbc3c52df0/7a91fed9-9e48-43ca-8487-ab262b3995c3.jpg)

4. **Menambahkan Booking Kamar**

   Pengguna dapat menambahkan data booking melalui halaman form dengan mengisi informasi pemesanan hotel.
   

![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/3711b4cd4a104b6a5effd823cc90bcdbc3c52df0/7a91fed9-9e48-43ca-8487-ab262b3995c3.jpg)

5. **Edit Data Booking**

   Data booking yang sudah dibuat dapat diubah kembali melalui halaman form.
   

![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/2ac2e7d421cc3eb5260ec3ed1d9a820b46db8b5a/bd76d2e1-9776-4a8c-a4e4-a026b08b3909.jpg)

6. **Pemilihan Tanggal Menginap**

   Pengguna dapat memilih tanggal check-in dan check-out menggunakan kalender.
   

8. **Validasi Input Form**

   Aplikasi melakukan validasi input seperti format email dan panjang password.
   

![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/3b58463c5d85ad0e5b97400709f3d781d397d096/64e085fe-c243-449c-9ed9-db9865e470ed.jpg)


![image alt](https://github.com/Ihsann333/minpro_2_PAB/blob/3b58463c5d85ad0e5b97400709f3d781d397d096/81a4e8a6-60dd-4aa2-a003-98557125c9ef.jpg)

8. **Light Mode dan Dark Mode**

   Pengguna dapat mengganti tampilan aplikasi antara tema terang dan tema gelap.

## Widget yang Digunakan

1. **MaterialApp**

   Digunakan sebagai root aplikasi untuk mengatur tema dan navigasi.

3. **ThemeData**

   Digunakan untuk mengatur tampilan tema aplikasi seperti Light Mode dan Dark Mode.

5. **StatelessWidget dan StatefulWidget**

   Digunakan untuk membuat halaman aplikasi yang statis maupun dinamis.

7. **Scaffold**

   Digunakan sebagai kerangka utama halaman aplikasi.

9. **AppBar**

   Digunakan untuk menampilkan judul halaman di bagian atas layar.

11. **Text dan TextStyle**

   Digunakan untuk menampilkan teks pada aplikasi.

13. **TextField**

   Digunakan untuk menerima input dari pengguna seperti email dan password.

15. **ElevatedButton dan TextButton**

   Digunakan sebagai tombol aksi seperti login, register, dan booking.

17. **Icon dan IconButton**

   Digunakan untuk menampilkan ikon serta tombol dengan ikon.

19. **ListView dan ListTile**

    Digunakan untuk menampilkan daftar booking secara dinamis.

21. **Container, Padding, SizedBox, Column, Row**

    Digunakan untuk mengatur layout dan tata letak komponen pada tampilan aplikasi.

23. **SingleChildScrollView**

    Digunakan agar halaman form dapat di-scroll.

25. **SnackBar**

    Digunakan untuk menampilkan notifikasi kepada pengguna.

27. **CircularProgressIndicator**

    Digunakan untuk menampilkan indikator proses loading.

29. **showDatePicker**

    Digunakan untuk memilih tanggal check-in dan check-out melalui kalender.

31. **Navigator dan MaterialPageRoute**

    Digunakan untuk berpindah halaman antar screen dalam aplikasi.

33. **ValueNotifier dan ValueListenableBuilder**
    Digunakan untuk mengatur perubahan tema aplikasi secara dinamis.
