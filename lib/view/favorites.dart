import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: firestoreService.getFavoriteQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Could not load favorites.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final favoriteQuotes = snapshot.data?.docs ?? [];

          if (favoriteQuotes.isEmpty) {
            return const Center(child: Text('No favorite quotes yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteQuotes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final document = favoriteQuotes[index];
              final data = document.data();
              final quote = data['quote'] as String? ?? '';
              final author = data['author'] as String? ?? '';

              return Card(
                child: ListTile(
                  title: Text(quote),
                  subtitle: Text('— $author'),
                  trailing: IconButton(
                    onPressed: () async {
                      await firestoreService.deleteFavoriteQuote(document.id);
                    },
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Delete quote',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
