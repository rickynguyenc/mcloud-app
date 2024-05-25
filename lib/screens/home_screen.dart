import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcloud/models/quote_model.dart';
import 'package:mcloud/providers/quote_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/quote_service.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  void _refresh(WidgetRef ref) {
    ref.refresh(quoteProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Quotes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              height: 200,
              color: Colors.green,
              alignment: Alignment.center,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _refresh(ref),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
