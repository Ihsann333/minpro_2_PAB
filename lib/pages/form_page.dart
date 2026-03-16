import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/supabase.services.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, this.booking});

  final Booking? booking;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final service = SupabaseService();

  int kamarDewasa = 1;
  int kamarAnak = 0;

  // DATA HOTEL
  final Map<String, int> hotelSamarinda = {
    'FOX Lite Hotel Samarinda': 350000,
    'Bumi Senyiur Samarinda': 420000,
    'Hotel Diamond Samarinda': 300000,
    'Ibis Samarinda': 500000,
    'Harris Hotel Samarinda': 550000,
  };

  int hargaPerKamar = 0;

  DateTime? checkInDate;
  DateTime? checkOutDate;

  final hotelController = TextEditingController();
  final checkInController = TextEditingController();
  final checkOutController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.booking != null) {

      hotelController.text = widget.booking!.namaTamu;
      checkInController.text = widget.booking!.checkIn;
      checkOutController.text = widget.booking!.checkOut;

      final text = widget.booking!.nomorKamar;

      try {

        final parts = text.split("•");

        kamarDewasa = int.parse(
          parts[0].replaceAll("kamar dewasa", "").trim(),
        );

        kamarAnak = int.parse(
          parts[1].replaceAll("kamar anak", "").trim(),
        );

      } catch (e) {

        kamarDewasa = 1;
        kamarAnak = 0;

      }
    }
  }

  // PILIH HOTEL
  void pilihHotel() {
    showModalBottomSheet(
      context: context,
      builder: (context) {

        return ListView(
          children: hotelSamarinda.entries.map((hotel) {

            return ListTile(
              leading: const Icon(Icons.hotel),
              title: Text(hotel.key),
              subtitle: Text("Rp ${hotel.value} / malam"),

              onTap: () {

                setState(() {
                  hotelController.text = hotel.key;
                  hargaPerKamar = hotel.value;
                });

                Navigator.pop(context);
              },
            );

          }).toList(),
        );
      },
    );
  }

  // PILIH TANGGAL
  Future pilihTanggal(TextEditingController controller) async {

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    if (picked == null) return;

    if (controller == checkInController) {

      checkInDate = picked;
      controller.text = "${picked.day}/${picked.month}/${picked.year}";

      if (checkOutDate != null &&
          checkOutDate!.isBefore(checkInDate!)) {

        checkOutDate = null;
        checkOutController.clear();
      }
    }

    if (controller == checkOutController) {

      if (checkInDate == null) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pilih check-in dulu"),
          ),
        );
        return;
      }

      if (picked.isBefore(checkInDate!)) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Check-out tidak boleh sebelum check-in",
            ),
          ),
        );
        return;
      }

      checkOutDate = picked;
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  Future simpan() async {

    if (kamarDewasa == 0 && kamarAnak == 0) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Minimal pesan 1 kamar"),
    ),
  );
  return;
}

    if (hotelController.text.isEmpty ||
        checkInController.text.isEmpty ||
        checkOutController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field wajib diisi"),
        ),
      );
      return;
    }

    int totalHarga =
        (hargaPerKamar * kamarDewasa) +
        ((hargaPerKamar ~/ 2) * kamarAnak);

    final booking = Booking(
      namaTamu: hotelController.text,
      nomorKamar:
      "$kamarDewasa kamar dewasa • $kamarAnak kamar anak",
      checkIn: checkInController.text,
      checkOut: checkOutController.text,
      harga: totalHarga,
    );

    if (widget.booking == null) {

      await service.addBooking(booking);

    } else {

      await service.updateBooking(
        widget.booking!.id!,
        booking,
      );

    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  Widget counter(String title, int value, Function(int) onChanged) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [

        Text(title, style: const TextStyle(fontSize: 16)),

        Row(
          children: [

            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                if (value > 0) {
                  setState(() {
                    onChanged(value - 1);
                  });
                }
              },
            ),

            Text("$value", style: const TextStyle(fontSize: 18)),

            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() {
                  onChanged(value + 1);
                });
              },
            ),

          ],
        )

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
          widget.booking == null
              ? "Booking Hotel"
              : "Edit Booking",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(
              controller: hotelController,
              readOnly: true,
              onTap: pilihHotel,
              decoration: const InputDecoration(
                labelText: "Pilih Hotel",
                prefixIcon: Icon(Icons.hotel),
              ),
            ),

            const SizedBox(height:16),

            TextField(
              controller: checkInController,
              readOnly: true,
              onTap: () => pilihTanggal(checkInController),
              decoration: const InputDecoration(
                labelText: "Check In",
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),

            const SizedBox(height:16),

            TextField(
              controller: checkOutController,
              readOnly: true,
              onTap: () => pilihTanggal(checkOutController),
              decoration: const InputDecoration(
                labelText: "Check Out",
                prefixIcon: Icon(Icons.calendar_month),
              ),
            ),

            const SizedBox(height:16),

            counter(
              "Kamar Dewasa",
              kamarDewasa,
              (v) => kamarDewasa = v,
            ),

            counter(
              "Kamar Anak",
              kamarAnak,
              (v) => kamarAnak = v,
            ),

            const SizedBox(height:20),

            if (hargaPerKamar > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Total Harga: Rp ${(hargaPerKamar * kamarDewasa) + ((hargaPerKamar ~/ 2) * kamarAnak)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),

            const SizedBox(height:20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: simpan,
                child: const Text("Booking Sekarang"),
              ),
            )

          ],
        ),
      ),
    );
  }
}