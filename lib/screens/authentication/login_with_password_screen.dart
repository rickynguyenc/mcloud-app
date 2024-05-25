import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/authentication_provider.dart';

@RoutePage()
class LoginWithPasswordScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final _rememberLogin = useState(false);
    final _username = useState('');
    final _password = useState('');

    return Scaffold(
      appBar: AppBar(leading: BackButton()),
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
            CheckboxListTile(
              title: Text('Remember login'),
              value: _rememberLogin.value,
              onChanged: (bool? value) {
                _rememberLogin.value = value ?? false;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ref.read(authProvider).login();
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
