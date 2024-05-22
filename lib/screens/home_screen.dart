import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameportalapp/models/quote_model.dart';
import 'package:gameportalapp/providers/quote_provider.dart';
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
      body: Center(
        child: _Quote(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _refresh(ref),
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class _Quote extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(quoteServiceProvider).getQuotes({}),
        builder: (context, AsyncSnapshot<List<BaseQuoteModel>> snapshot) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(30),
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width - 60,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data![index].text!, style: Theme.of(context).textTheme.headline5),
                    SizedBox(
                      height: 20,
                    ),
                    Text(snapshot.data![index].author!, style: Theme.of(context).textTheme.subtitle2)
                  ],
                ),
              );
            },
          );
        });
  }
}

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Error occured"),
    );
  }
}
