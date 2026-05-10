import 'dart:math';

import 'package:flutter/material.dart';

import '../models/quote.dart';
import 'favorites.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();

  late Map<String, String> _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = quotes[_random.nextInt(quotes.length)];
  }

  void _getNewQuote() {
    setState(() {
      _currentQuote = quotes[_random.nextInt(quotes.length)];
    });
  }

  void _saveToFavorites() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Quote saved to favorites.')));
  }

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Quote'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.format_quote, size: 48),
                      const SizedBox(height: 20),
                      Text(
                        _currentQuote['quote'] ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '— ${_currentQuote['author'] ?? ''}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _getNewQuote,
                  icon: const Icon(Icons.refresh),
                  label: const Text('New Quote'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saveToFavorites,
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('Save to favorites'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: _openFavorites,
                  icon: const Icon(Icons.list),
                  label: const Text('View Favorites'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
