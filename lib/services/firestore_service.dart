import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  CollectionReference<Map<String, dynamic>> get _favoritesCollection {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorite_quotes');
  }

  Future<void> saveFavoriteQuote(Map<String, String> quote) async {
    await _favoritesCollection.add({
      'quote': quote['quote'],
      'author': quote['author'],
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteQuotes() {
    return _favoritesCollection
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteFavoriteQuote(String documentId) async {
    await _favoritesCollection.doc(documentId).delete();
  }
}
