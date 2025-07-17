import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:figma21/models/address.dart';

class AddressCubit extends Cubit<List<Address>> {
  AddressCubit() : super([]);

  final _firestore = FirebaseFirestore.instance;

  Future<void> loadAddresses(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .get();
    final addresses = snapshot.docs.map((doc) => Address.fromFirestore(doc)).toList();
    emit(addresses);
  }

  Future<void> addAddress(Address address,String userId,) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(address.id)
        .set(address.toMap());

    final update = List<Address>.from(state)..add(address);
    emit(update);
  }

  Future<void> updateAddress(Address address,String userId,) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(address.id)
        .update(address.toMap());
    final update = state.map((a) => a.id == address.id ? address : a).toList();
    emit(update);
  }

  Future<void> deleteAddress(String userId, String addressId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(addressId)
        .delete();
    final update = state.where((a) => a.id != addressId).toList();
    emit(update);
  }
}
