import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ForgotPasswordScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final _email = useState('');

    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onChanged: (value) => _email.value = value,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement forgot password logic
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
