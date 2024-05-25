import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RegisterScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final _username = useState('');
    final _password = useState('');
    final _confirmPassword = useState('');

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              onChanged: (value) => _username.value = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onChanged: (value) => _password.value = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _password.value) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onChanged: (value) => _confirmPassword.value = value,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: Implement registration logic
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
