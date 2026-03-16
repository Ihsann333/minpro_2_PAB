import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../main.dart';
import '../services/supabase.services.dart';
import 'form_page.dart';
import 'login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final service = SupabaseService();
  List<Booking> bookingList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final data = await service.getBookings();

    setState(() {
      bookingList = data;
    });

  }

  Future hapusBooking(int id) async {

    await service.deleteBooking(id);

    loadData();
  }

  @override
  Widget build(BuildContext context) {

    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    final cardColor = Theme.of(context).cardColor;

    return Scaffold(

      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.hotel,
              color: Colors.blue,
              size: 28,
            ),
            const SizedBox(width: 10),
            const Text(
              'RoomAja',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),

        actions: [

          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {

              if (themeNotifier.value == ThemeMode.light) {
                themeNotifier.value = ThemeMode.dark;
              } else {
                themeNotifier.value = ThemeMode.light;
              }

            },
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {

              await Supabase.instance.client.auth.signOut();

              if (!mounted) return;

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );

            },
          ),

        ],
      ),

      body: Stack(
        children: [

          Positioned.fill(
            child: Image.network(
              'https://awsimages.detik.net.id/community/media/visual/2024/11/14/tempat-staycation-2.jpeg?w=800',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          SafeArea(

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [

                  GestureDetector(

                    onTap: () async {

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FormPage(),
                        ),
                      );

                      loadData();

                    },

                    child: Container(

                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      height: 58,

                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [

                          const Icon(Icons.hotel),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              "Pilih hotel, kamar & tanggal",
                              style: TextStyle(color: textColor),
                            ),
                          ),

                          const Icon(Icons.search),

                        ],
                      ),

                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(

                    child: bookingList.isEmpty

                        ? const Center(
                            child: Text(
                              "Belum ada booking",
                              style: TextStyle(color: Colors.white),
                            ),
                          )

                        : ListView.builder(

                            itemCount: bookingList.length,

                            itemBuilder: (context, index) {

                              final data = bookingList[index];

                              return Container(

                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),

                                padding: const EdgeInsets.all(14),

                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [

                                        Text(
                                          "Booking Nomor ${index + 1}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),

                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () =>
                                              hapusBooking(data.id!),
                                        ),

                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      data.namaTamu,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      "Kamar: ${data.nomorKamar}",
                                      style: TextStyle(color: textColor),
                                    ),

                                    Text(
                                      "In: ${data.checkIn} • Out: ${data.checkOut}",
                                      style: TextStyle(color: textColor),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "Total: Rp ${data.harga}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Align(
                                      alignment: Alignment.centerRight,

                                      child: TextButton.icon(

                                        onPressed: () async {

                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  FormPage(booking: data),
                                            ),
                                          );

                                          loadData();

                                        },

                                        icon: const Icon(Icons.edit, size: 18),
                                        label: const Text("Edit"),

                                      ),
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                  )

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}