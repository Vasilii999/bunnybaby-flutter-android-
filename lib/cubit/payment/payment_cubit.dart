import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/models/payment_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<List<PaymentCard>> {
  PaymentCubit() : super([]);

  final _firestore = FirebaseFirestore.instance;

  Future<void> loadPaymentCards(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('paymentCards')
        .get();
    final cards =
        snapshot.docs.map((doc) => PaymentCard.fromMap(doc.data())).toList();
    emit(cards);
  }

  Future<void> addCard(PaymentCard  card) async {
    await _firestore
        .collection('users')
        .doc(card.userId)
        .collection('paymentCards')
        .doc(card.id)
        .set(card.toMap());

    final update = List<PaymentCard>.from(state)..add(card);
    emit(update);
  }

  Future<void> updateCard(PaymentCard  card) async {
    await _firestore
        .collection('users')
        .doc(card.userId)
        .collection('paymentCards')
        .doc(card.id)
        .update(card.toMap());
    final update = state.map((a) => a.id == card.id ? card : a).toList();
    emit(update);
  }

  Future<void> deleteCard(String userId, String cardId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('paymentCards')
        .doc(cardId)
        .delete();
    final update = state.where((c) => c.id != cardId).toList();
    emit(update);
  }
}
