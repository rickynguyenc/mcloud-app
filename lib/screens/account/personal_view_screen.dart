import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class PersonalViewScreen extends HookConsumerWidget {
  const PersonalViewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
      ),
      body: Container(child: Text('Tài khoản screen')),
    );
  }
}
