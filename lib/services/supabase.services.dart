import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking.dart';

class SupabaseService {

  final supabase = Supabase.instance.client;

  Future<List<Booking>> getBookings() async {

    final user = supabase.auth.currentUser;

    final response = await supabase
        .from('bookings')
        .select()
        .eq('user_id', user!.id)
        .order('id');

    final List data = response;

    return data.map((e) => Booking.fromJson(e)).toList();
  }

  Future addBooking(Booking booking) async {

    final user = supabase.auth.currentUser;

    await supabase.from('bookings').insert({
      ...booking.toJson(),
      'user_id': user!.id,
    });

  }

  Future updateBooking(int id, Booking booking) async {

    await supabase
        .from('bookings')
        .update(booking.toJson())
        .eq('id', id);

  }

  Future deleteBooking(int id) async {

    await supabase
        .from('bookings')
        .delete()
        .eq('id', id);

  }

}  