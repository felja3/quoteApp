import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _favoritesCollection =
      FirebaseFirestore.instance.collection('favorite_quotes');

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
